# Blender Action

![GitHub Action](https://img.shields.io/badge/action-blender-blue)

**Blender Action** is a GitHub Action that automates Blender tasks such as exporting a 3D model to an STL file or rendering to PNG. This action can be used in CI pipelines to convert `.blend` files directly from your repository.

## 📦 Features

- Automate 3D model exports and renders in your CI/CD workflow
- Supports Blender `.blend` to `.stl` and `.png` conversion
- Runs inside a Docker container for consistency

## 🧰 Inputs

| Name             | Description                          | Required | Default      |
|------------------|--------------------------------------|----------|--------------|
| `input_file`     | Path to the Blender source file      | ✅ Yes   | —            |
| `output_file`    | Path to export STL file              | ❌ No    | —            |
| `render_file`    | Path to rendered PNG file (frame 1)  | ❌ No    | —            |
| `export_selected`| Export only selected objects         | ❌ No    | false        |

## 🚀 Usage

### Export STL

```yaml
- name: Export 3D Model
  uses: vikulin/blender-action@v1
  with:
    input_file: models/my_model.blend
    output_file: export/my_model.stl
```

### Export Only Selected Objects

```yaml
- name: Export Selected Objects
  uses: vikulin/blender-action@v1
  with:
    input_file: models/my_model.blend
    output_file: export/selected_objects.stl
    export_selected: true
```

### Render PNG

```yaml
- name: Render PNG
  uses: vikulin/blender-action@v1
  with:
    input_file: models/my_model.blend
    render_file: render/preview.png
```

## 🖼️ Rendering Output

Choose the location to save rendered frames.

When rendering an animation, the frame number is appended at the end of the file name with four padded zeros by default.

For example:

```yaml
render_file: render/image.png
```

Will produce:

```
render/image0001.png
```

You can set a custom padding size by adding the appropriate number of `#` characters anywhere in the file name. Blender will replace the `#` with the frame number:

* `render/image_##_test.png` → `render/image_01_test.png`
* `render/preview_####.png` → `render/preview_0001.png`

---

> 💬 Have suggestions or questions? Feel free to open an issue or submit a PR.
