# Helm .Files Functions Examples

This repository contains comprehensive examples of Helm's `.Files` functions for working with files in Helm templates.

## Overview

Helm provides several functions for accessing and manipulating files within your chart. These functions are essential for including configuration files, secrets, and other static assets in your Kubernetes manifests.

## Function Examples

### 1. `.Files.Get` - Get file contents as string

**Purpose**: Retrieves the contents of a file as a string.

**Example**:
```yaml
# Get file contents as string
config.txt: |
{{ .Files.Get "config/config.txt" | indent 4 }}
```

**Use Cases**:
- Including configuration files in ConfigMaps
- Reading text-based configuration
- Embedding documentation or scripts

### 2. `.Files.GetBytes` - Get file as bytes

**Purpose**: Retrieves file contents as a byte array ([]byte in Go).

**Example**:
```yaml
# Get file as bytes (Base64 encoded for Secret)
binary-data: {{ .Files.GetBytes "data/binary.dat" | b64enc }}
```

**Use Cases**:
- Including binary files in Kubernetes Secrets
- Working with certificates, keys, or other binary data
- When you need the raw bytes rather than string representation

### 3. `.Files.Glob` - Pattern matching for files

**Purpose**: Returns files matching a glob pattern.

**Example**:
```yaml
# Include all JSON files in config directory
{{- range $path, $bytes := .Files.Glob "config/*.json" }}
{{ $path }}: |
{{ $.Files.Get $path | indent 4 }}
{{- end }}
```

**Use Cases**:
- Including multiple files of the same type
- Dynamic file inclusion based on patterns
- Bulk processing of configuration files

### 4. `.Files.AsConfig` - Convert files to ConfigMap format

**Purpose**: Converts a group of files to flattened YAML suitable for ConfigMap data section.

**Example**:
```yaml
# Convert all YAML files to ConfigMap format
data:
{{ .Files.Glob "config/**/*.yaml" | .Files.AsConfig | indent 2 }}
```

**Use Cases**:
- Bulk inclusion of configuration files
- Automatic key generation from file paths
- Simplified ConfigMap creation

### 5. `.Files.AsSecrets` - Convert files to Secret format

**Purpose**: Converts files to Base64-encoded format suitable for Kubernetes Secret data section.

**Example**:
```yaml
# Convert all files in secrets directory to Secret format
data:
{{ .Files.Glob "secrets/**/*" | .Files.AsSecrets | indent 2 }}
```

**Use Cases**:
- Including sensitive files (keys, certificates, passwords)
- Bulk secret management
- Automatic Base64 encoding for binary data

### 6. `.Files.Lines` - Get file as array of lines

**Purpose**: Returns file contents as an array split by newlines.

**Example**:
```yaml
# Each line becomes a separate ConfigMap entry
{{- $lines := .Files.Lines "data/whitelist.txt" }}
{{- range $index, $line := $lines }}
line-{{ add $index 1 }}: {{ $line | quote }}
{{- end }}

# Or join lines back into a single string
whitelist-combined: |
{{ .Files.Lines "data/whitelist.txt" | join "\n" | indent 4 }}
```

**Use Cases**:
- Processing line-by-line data (IP whitelists, user lists)
- Creating individual entries for each line
- Text processing and manipulation

## Advanced Examples

### JSON Processing
```yaml
# Read JSON file and extract specific values
database-url: {{ (.Files.Get "config/app-config.json" | fromJson).database.url | quote }}
```

### Multiple File Types
```yaml
# Include different file types in separate sections
{{- range $path, $bytes := .Files.Glob "config/*.yaml" }}
{{ $path | base }}: |
{{ $.Files.Get $path | indent 4 }}
{{- end }}
```

## File Structure

The examples assume the following file structure in your Helm chart:

```
chart/
├── templates/
│   └── helm-files-examples.yaml
├── config/
│   ├── config.txt
│   ├── app-config.json
│   └── settings.yaml
├── data/
│   ├── whitelist.txt
│   └── binary.dat
└── secrets/
    └── database.key
```

## Best Practices

1. **Security**: Use `.Files.AsSecrets` for sensitive data
2. **Organization**: Group related files in directories
3. **Patterns**: Use `.Files.Glob` for dynamic file inclusion
4. **Validation**: Always test your templates with `helm template`
5. **Documentation**: Comment your templates for clarity

## Usage

To use these examples:

1. Copy the template file to your chart's `templates/` directory
2. Create the sample files in the appropriate directories
3. Run `helm template .` to see the rendered output
4. Customize the examples for your specific use case

## Notes

- All file paths are relative to the chart root
- Binary files are automatically Base64 encoded when using `.Files.AsSecrets`
- The `indent` function is used for proper YAML formatting
- Use `{{- }}` for whitespace control in templates 