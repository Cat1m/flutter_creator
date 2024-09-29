package main

import (
	"bufio"
	"embed"
	"fmt"
	"io"
	"io/fs"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"strings"
)

//go:embed flutter_base
var templateFS embed.FS

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Please provide a project name.")
		os.Exit(1)
	}

	projectName := os.Args[1]

	// Ask for user input on where to save the project
	savePath, err := askForSavePath(projectName)
	if err != nil {
		fmt.Printf("Error determining save path: %v\n", err)
		os.Exit(1)
	}

	// Check if the directory exists, if not, create it
	if err := ensureDirectoryExists(savePath); err != nil {
		fmt.Printf("Error ensuring directory exists: %v\n", err)
		os.Exit(1)
	}

	// Create the Flutter project
	if err := createFlutterProjectAtPath(savePath); err != nil {
		fmt.Printf("Error creating Flutter project: %v\n", err)
		os.Exit(1)
	}

	// Remove the default lib directory and copy template structure
	if err := os.RemoveAll(filepath.Join(savePath, "lib")); err != nil {
		fmt.Printf("Error removing default lib content: %v\n", err)
		os.Exit(1)
	}

	if err := copyTemplateStructure(savePath); err != nil {
		fmt.Printf("Error copying template structure: %v\n", err)
		os.Exit(1)
	}

	// Merge pubspec.yaml
	if err := mergePubspec(savePath); err != nil {
		fmt.Printf("Error merging pubspec.yaml: %v\n", err)
		os.Exit(1)
	}

	// Initialize a git repository
	if err := initGit(savePath); err != nil {
		fmt.Printf("Error initializing git repository: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("SOLID Flutter project '%s' created successfully at '%s'!\n", projectName, savePath)
}

func createFlutterProjectAtPath(savePath string) error {
	cmd := exec.Command("flutter", "create", savePath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	fmt.Printf("Creating Flutter project at: %s\n", savePath)
	err := cmd.Run()
	if err != nil {
		fmt.Printf("Error running flutter create: %v\n", err)
		return err
	}
	return nil
}

func copyTemplateStructure(projectName string) error {
	return fs.WalkDir(templateFS, "flutter_base", func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		relPath, err := filepath.Rel("flutter_base", path)
		if err != nil {
			return err
		}

		dstPath := filepath.Join(projectName, relPath)

		if d.IsDir() {
			return os.MkdirAll(dstPath, 0755)
		}

		src, err := templateFS.Open(path)
		if err != nil {
			return err
		}
		defer src.Close()

		dst, err := os.Create(dstPath)
		if err != nil {
			return err
		}
		defer dst.Close()

		_, err = io.Copy(dst, src)
		return err
	})
}

func mergePubspec(projectName string) error {
	templatePubspec, err := templateFS.ReadFile("flutter_base/pubspec.yaml")
	if err != nil {
		return err
	}

	projectPubspecPath := filepath.Join(projectName, "pubspec.yaml")
	err = os.WriteFile(projectPubspecPath, templatePubspec, 0644)
	if err != nil {
		return err
	}

	return nil
}

func initGit(projectName string) error {
	cmds := [][]string{
		{"git", "init"},
		{"git", "add", "."},
		{"git", "commit", "-m", "Initial commit: Flutter project structure"},
	}

	for _, cmdArgs := range cmds {
		cmd := exec.Command(cmdArgs[0], cmdArgs[1:]...)
		cmd.Dir = projectName
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			return err
		}
	}

	return nil
}

func getDefaultSavePath(projectName string) (string, error) {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		return "", err
	}

	var desktopPath string
	switch runtime.GOOS {
	case "windows":
		desktopPath = filepath.Join(homeDir, "Desktop", projectName)
	case "darwin": // macOS
		desktopPath = filepath.Join(homeDir, "Desktop", projectName)
	case "linux":
		desktopPath = filepath.Join(homeDir, "Desktop", projectName)
	default:
		return "", fmt.Errorf("unsupported OS: %s", runtime.GOOS)
	}

	return desktopPath, nil
}

func askForSavePath(projectName string) (string, error) {
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("Please enter the directory where you want to save the project (or press Enter to save on Desktop):")
	userInput, _ := reader.ReadString('\n')
	userInput = strings.TrimSpace(userInput)

	if userInput == "" || userInput == "." {
		// Use default Desktop path if user doesn't provide input
		return getDefaultSavePath(projectName)
	}
	return filepath.Join(userInput, projectName), nil
}

// Ensure that the directory exists or create it if it doesn't
func ensureDirectoryExists(path string) error {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		if err := os.MkdirAll(path, os.ModePerm); err != nil {
			return fmt.Errorf("failed to create directory: %v", err)
		}
	}
	return nil
}
