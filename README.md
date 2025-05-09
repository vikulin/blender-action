# Blender Action

![GitHub Action](https://img.shields.io/badge/action-blender-blue)

**Blender Action** is a GitHub Action that automates Blender tasks such as exporting a 3D model to an STL file. This action can be used in CI pipelines to convert `.blend` files to `.stl` format directly from your repository.

## 📦 Features

- Automate 3D model exports in your CI/CD workflow
- Supports Blender `.blend` to `.stl` conversion
- Runs inside a Docker container for consistency

## 🧰 Inputs

| Name         | Description                        | Required | Default      |
|--------------|------------------------------------|----------|--------------|
| `input-file` | Path to the Blender source file    | ✅ Yes   | —            |
| `output-file`| Name of the resulting STL file     | ✅ Yes   | `output.stl` |

## 🚀 Usage

Here’s a basic example of how to use this action in your workflow:

```yaml
name: Export 3D Model

on:
  push:
    paths:
      - '**.blend'

jobs:
  export-model:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run Blender Export
        uses: vikulin/blender-action@v1
        with:
          input-file: models/my_model.blend
          output-file: export/my_model.stl
````

## 🐳 How it Works

This action runs in a Docker container defined by your `Dockerfile`. It passes the input and output filenames as arguments to the container, where Blender runs in headless mode to perform the export.

---

> 💬 Have suggestions or questions? Feel free to open an issue or submit a PR.
