# Logo Dimensions - Implementation Examples

## Example 1: React Component

```typescript
// components/settings/LogoUpload.tsx

import React from 'react';
import { InfoCircleOutlined } from '@ant-design/icons';
import { Tooltip, Upload } from 'antd';

const LogoDimensionsHelper = () => {
  const dimensionsText = (
    <div>
      <p><strong>Dimensioni consigliate:</strong></p>
      <ul>
        <li>Logo quadrato (1:1): 200px × 200px o 300px × 300px</li>
        <li>Logo orizzontale (2:1): 300px × 150px o 400px × 200px</li>
        <li>Logo orizzontale (3:1): 300px × 100px o 600px × 200px</li>
      </ul>
      <p><small>Formato: PNG, JPG, SVG | Max: 2MB</small></p>
    </div>
  );

  return (
    <Tooltip title={dimensionsText} placement="right">
      <InfoCircleOutlined style={{ marginLeft: 8, color: '#1890ff' }} />
    </Tooltip>
  );
};

export default LogoDimensionsHelper;
```

## Example 2: Vue Component

```vue
<!-- components/settings/LogoUpload.vue -->

<template>
  <div class="logo-upload">
    <h3>
      Carica Logo
      <el-tooltip placement="right" effect="light">
        <template #content>
          <div class="logo-dimensions-info">
            <p><strong>Dimensioni consigliate:</strong></p>
            <ul>
              <li>Logo quadrato (1:1): 200px × 200px o 300px × 300px</li>
              <li>Logo orizzontale (2:1): 300px × 150px o 400px × 200px</li>
              <li>Logo orizzontale (3:1): 300px × 100px o 600px × 200px</li>
            </ul>
            <p><small>Formato: PNG, JPG, SVG | Max: 2MB</small></p>
          </div>
        </template>
        <el-icon><InfoFilled /></el-icon>
      </el-tooltip>
    </h3>
    <el-upload
      :auto-upload="false"
      :on-change="handleLogoChange"
      accept="image/png,image/jpeg,image/svg+xml"
    >
      <el-button>Scegli File</el-button>
    </el-upload>
  </div>
</template>

<style scoped>
.logo-dimensions-info ul {
  margin: 8px 0;
  padding-left: 20px;
}
.logo-dimensions-info li {
  margin: 4px 0;
}
</style>
```

## Example 3: HTML + CSS (Static)

```html
<!-- settings/general/logo.html -->

<div class="logo-upload-section">
  <label for="logo-upload">
    Logo dell'Ente
    <span class="info-icon" data-tooltip="dimensions-tooltip">ⓘ</span>
  </label>
  
  <div id="dimensions-tooltip" class="tooltip-content">
    <p><strong>Dimensioni consigliate:</strong></p>
    <ul>
      <li>Logo quadrato (1:1): 200px × 200px o 300px × 300px</li>
      <li>Logo orizzontale (2:1): 300px × 150px o 400px × 200px</li>
      <li>Logo orizzontale (3:1): 300px × 100px o 600px × 200px</li>
    </ul>
    <p class="file-specs">Formato: PNG, JPG, SVG | Dimensione massima: 2MB</p>
  </div>
  
  <input type="file" id="logo-upload" accept="image/png,image/jpeg,image/svg+xml" />
</div>

<style>
.logo-upload-section {
  position: relative;
  margin: 20px 0;
}

.info-icon {
  display: inline-block;
  margin-left: 8px;
  color: #1890ff;
  cursor: help;
  font-weight: bold;
}

.tooltip-content {
  display: none;
  position: absolute;
  background: white;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  z-index: 1000;
  min-width: 300px;
}

.info-icon:hover + .tooltip-content,
.tooltip-content:hover {
  display: block;
}

.file-specs {
  margin-top: 8px;
  font-size: 12px;
  color: #666;
}
</style>
```

## Example 4: Angular Component

```typescript
// components/settings/logo-upload/logo-upload.component.ts

import { Component } from '@angular/core';

@Component({
  selector: 'app-logo-upload',
  template: `
    <div class="logo-upload-container">
      <h3>
        Carica Logo
        <mat-icon
          matTooltip="Dimensioni consigliate:
• Logo quadrato (1:1): 200px × 200px o 300px × 300px
• Logo orizzontale (2:1): 300px × 150px o 400px × 200px
• Logo orizzontale (3:1): 300px × 100px o 600px × 200px

Formato: PNG, JPG, SVG | Max: 2MB"
          matTooltipClass="logo-dimensions-tooltip"
          class="info-icon">
          info
        </mat-icon>
      </h3>
      <input
        type="file"
        (change)="onFileSelected($event)"
        accept="image/png,image/jpeg,image/svg+xml"
        #fileInput
      />
    </div>
  `,
  styles: [`
    .info-icon {
      color: #1890ff;
      cursor: help;
      font-size: 18px;
      vertical-align: middle;
      margin-left: 8px;
    }
  `]
})
export class LogoUploadComponent {
  onFileSelected(event: Event) {
    // Handle file upload
  }
}
```

## Example 5: Flutter/Dart (Mobile)

```dart
// lib/widgets/logo_upload_widget.dart

import 'package:flutter/material.dart';

class LogoUploadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Logo dell\'Ente',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Tooltip(
              message: 'Tocca per vedere le dimensioni consigliate',
              child: IconButton(
                icon: Icon(Icons.info_outline, color: Colors.blue),
                onPressed: () => _showDimensionsDialog(context),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _pickImage(),
          child: Text('Scegli File'),
        ),
      ],
    );
  }

  void _showDimensionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Dimensioni Consigliate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Logo quadrato (1:1):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('  200px × 200px o 300px × 300px'),
            SizedBox(height: 8),
            Text('• Logo orizzontale (2:1):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('  300px × 150px o 400px × 200px'),
            SizedBox(height: 8),
            Text('• Logo orizzontale (3:1):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('  300px × 100px o 600px × 200px'),
            SizedBox(height: 16),
            Text('Formato: PNG, JPG, SVG',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text('Dimensione massima: 2MB',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _pickImage() {
    // Implement image picker
  }
}
```

## Internationalization (i18n) Example

```json
// locales/it.json
{
  "settings": {
    "general": {
      "logo": {
        "title": "Logo dell'Ente",
        "dimensions_title": "Dimensioni consigliate",
        "square_logo": "Logo quadrato (1:1): 200px × 200px o 300px × 300px",
        "horizontal_logo_2_1": "Logo orizzontale (2:1): 300px × 150px o 400px × 200px",
        "horizontal_logo_3_1": "Logo orizzontale (3:1): 300px × 100px o 600px × 200px",
        "format": "Formato: PNG, JPG, SVG",
        "max_size": "Dimensione massima: 2MB"
      }
    }
  }
}
```

## CSS Utility Classes

```css
/* styles/logo-upload.css */

.logo-dimensions-helper {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  margin-left: 8px;
}

.logo-dimensions-icon {
  color: #1890ff;
  cursor: help;
  font-size: 16px;
}

.logo-dimensions-tooltip {
  background: white;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
  padding: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
  max-width: 350px;
}

.logo-dimensions-list {
  margin: 8px 0;
  padding-left: 20px;
  list-style-type: disc;
}

.logo-dimensions-list li {
  margin: 6px 0;
  line-height: 1.5;
}

.logo-file-specs {
  margin-top: 12px;
  padding-top: 8px;
  border-top: 1px solid #f0f0f0;
  font-size: 12px;
  color: #666;
}
```
