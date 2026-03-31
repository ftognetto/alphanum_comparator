# Rendiconto Error Message - Implementation Examples

## Example 1: React Component with Hardcoded Message

```typescript
// components/reports/UnapprovedExpensesWarning.tsx

import React from 'react';
import { Alert, Button } from 'antd';
import { ExclamationCircleOutlined } from '@ant-design/icons';

interface UnapprovedExpensesWarningProps {
  count: number;
  onContinue: () => void;
  onGoToExpenses: () => void;
}

const UnapprovedExpensesWarning: React.FC<UnapprovedExpensesWarningProps> = ({
  count,
  onContinue,
  onGoToExpenses
}) => {
  const message = (
    <div>
      <p>
        Ci sono {count} {count === 1 ? 'voce' : 'voci'} di spesa non {count === 1 ? 'approvata' : 'approvate'} fra le uscite non visualizzate di seguito.
      </p>
      <p>
        Puoi continuare senza includere nel <strong>Rendiconto</strong>, o puoi tornare alla sezione 
        Uscite per verificare queste spese, eliminandole o approvandole.
      </p>
      <div style={{ marginTop: 16 }}>
        <Button onClick={onGoToExpenses} type="primary" style={{ marginRight: 8 }}>
          Vai alle Uscite
        </Button>
        <Button onClick={onContinue}>
          Continua Senza Includere
        </Button>
      </div>
    </div>
  );

  return (
    <Alert
      message="Attenzione: Voci di Spesa Non Approvate"
      description={message}
      type="warning"
      icon={<ExclamationCircleOutlined />}
      showIcon
    />
  );
};

export default UnapprovedExpensesWarning;
```

## Example 2: Vue Component

```vue
<!-- components/reports/UnapprovedExpensesWarning.vue -->

<template>
  <el-alert
    title="Attenzione: Voci di Spesa Non Approvate"
    type="warning"
    :closable="false"
    show-icon
  >
    <template #default>
      <p>
        Ci sono {{ count }} {{ count === 1 ? 'voce' : 'voci' }} di spesa non 
        {{ count === 1 ? 'approvata' : 'approvate' }} fra le uscite non visualizzate di seguito.
      </p>
      <p>
        Puoi continuare senza includere nel <strong>Rendiconto</strong>, o puoi tornare alla sezione 
        Uscite per verificare queste spese, eliminandole o approvandole.
      </p>
      <div class="action-buttons">
        <el-button type="primary" @click="goToExpenses">
          Vai alle Uscite
        </el-button>
        <el-button @click="continueWithoutIncluding">
          Continua Senza Includere
        </el-button>
      </div>
    </template>
  </el-alert>
</template>

<script setup lang="ts">
defineProps<{
  count: number
}>();

const emit = defineEmits<{
  continue: []
  goToExpenses: []
}>();

const goToExpenses = () => {
  emit('goToExpenses');
};

const continueWithoutIncluding = () => {
  emit('continue');
};
</script>

<style scoped>
.action-buttons {
  margin-top: 16px;
  display: flex;
  gap: 8px;
}
</style>
```

## Example 3: Angular Component

```typescript
// components/reports/unapproved-expenses-warning.component.ts

import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-unapproved-expenses-warning',
  template: `
    <div class="alert alert-warning" role="alert">
      <div class="alert-icon">
        <mat-icon>warning</mat-icon>
      </div>
      <div class="alert-content">
        <h4>Attenzione: Voci di Spesa Non Approvate</h4>
        <p>
          Ci sono {{ count }} {{ count === 1 ? 'voce' : 'voci' }} di spesa non 
          {{ count === 1 ? 'approvata' : 'approvate' }} fra le uscite non visualizzate di seguito.
        </p>
        <p>
          Puoi continuare senza includere nel <strong>Rendiconto</strong>, o puoi tornare alla sezione 
          Uscite per verificare queste spese, eliminandole o approvandole.
        </p>
        <div class="action-buttons">
          <button mat-raised-button color="primary" (click)="goToExpenses.emit()">
            Vai alle Uscite
          </button>
          <button mat-button (click)="continue.emit()">
            Continua Senza Includere
          </button>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .alert {
      display: flex;
      padding: 16px;
      border-radius: 4px;
      background-color: #fff3cd;
      border: 1px solid #ffc107;
    }
    .alert-icon {
      margin-right: 16px;
      color: #ff9800;
    }
    .alert-content {
      flex: 1;
    }
    .action-buttons {
      margin-top: 16px;
      display: flex;
      gap: 8px;
    }
  `]
})
export class UnapprovedExpensesWarningComponent {
  @Input() count: number = 0;
  @Output() continue = new EventEmitter<void>();
  @Output() goToExpenses = new EventEmitter<void>();
}
```

## Example 4: Internationalization (i18n) Files

### Italian Translation File
```json
// locales/it.json or i18n/it.json

{
  "reports": {
    "unapprovedExpenses": {
      "title": "Attenzione: Voci di Spesa Non Approvate",
      "message": "Ci sono {count} {count, plural, one {voce} other {voci}} di spesa non {count, plural, one {approvata} other {approvate}} fra le uscite non visualizzate di seguito.",
      "description": "Puoi continuare senza includere nel **Rendiconto**, o puoi tornare alla sezione Uscite per verificare queste spese, eliminandole o approvandole.",
      "actions": {
        "goToExpenses": "Vai alle Uscite",
        "continueWithout": "Continua Senza Includere"
      }
    }
  }
}
```

### Using i18n in React (with react-i18next)
```typescript
// components/reports/UnapprovedExpensesWarning.tsx

import React from 'react';
import { useTranslation } from 'react-i18next';
import { Alert, Button } from 'antd';

interface Props {
  count: number;
  onContinue: () => void;
  onGoToExpenses: () => void;
}

const UnapprovedExpensesWarning: React.FC<Props> = ({ count, onContinue, onGoToExpenses }) => {
  const { t } = useTranslation();

  return (
    <Alert
      message={t('reports.unapprovedExpenses.title')}
      description={
        <div>
          <p>{t('reports.unapprovedExpenses.message', { count })}</p>
          <p>{t('reports.unapprovedExpenses.description')}</p>
          <div style={{ marginTop: 16 }}>
            <Button onClick={onGoToExpenses} type="primary" style={{ marginRight: 8 }}>
              {t('reports.unapprovedExpenses.actions.goToExpenses')}
            </Button>
            <Button onClick={onContinue}>
              {t('reports.unapprovedExpenses.actions.continueWithout')}
            </Button>
          </div>
        </div>
      }
      type="warning"
      showIcon
    />
  );
};

export default UnapprovedExpensesWarning;
```

### Using i18n in Vue (with vue-i18n)
```vue
<!-- components/reports/UnapprovedExpensesWarning.vue -->

<template>
  <el-alert
    :title="$t('reports.unapprovedExpenses.title')"
    type="warning"
    :closable="false"
    show-icon
  >
    <template #default>
      <p>{{ $t('reports.unapprovedExpenses.message', { count }) }}</p>
      <p v-html="$t('reports.unapprovedExpenses.description')"></p>
      <div class="action-buttons">
        <el-button type="primary" @click="$emit('goToExpenses')">
          {{ $t('reports.unapprovedExpenses.actions.goToExpenses') }}
        </el-button>
        <el-button @click="$emit('continue')">
          {{ $t('reports.unapprovedExpenses.actions.continueWithout') }}
        </el-button>
      </div>
    </template>
  </el-alert>
</template>

<script setup lang="ts">
defineProps<{
  count: number
}>();

defineEmits<{
  continue: []
  goToExpenses: []
}>();
</script>
```

## Example 5: Constants File Approach

```typescript
// constants/messages.ts

export const REPORT_MESSAGES = {
  UNAPPROVED_EXPENSES_WARNING: {
    title: 'Attenzione: Voci di Spesa Non Approvate',
    getMessage: (count: number) => {
      const voce = count === 1 ? 'voce' : 'voci';
      const approvata = count === 1 ? 'approvata' : 'approvate';
      return `Ci sono ${count} ${voce} di spesa non ${approvata} fra le uscite non visualizzate di seguito.`;
    },
    description: 'Puoi continuare senza includere nel **Rendiconto**, o puoi tornare alla sezione Uscite per verificare queste spese, eliminandole o approvandole.',
    actions: {
      goToExpenses: 'Vai alle Uscite',
      continueWithout: 'Continua Senza Includere'
    }
  }
} as const;
```

Usage:
```typescript
import { REPORT_MESSAGES } from '@/constants/messages';

const message = REPORT_MESSAGES.UNAPPROVED_EXPENSES_WARNING.getMessage(unapprovedCount);
const description = REPORT_MESSAGES.UNAPPROVED_EXPENSES_WARNING.description;
```

## Example 6: Dialog/Modal Implementation

```typescript
// components/reports/UnapprovedExpensesDialog.tsx

import React from 'react';
import { Modal, Button, Alert } from 'antd';
import { ExclamationCircleFilled } from '@ant-design/icons';

interface Props {
  visible: boolean;
  count: number;
  onContinue: () => void;
  onGoToExpenses: () => void;
  onCancel: () => void;
}

const UnapprovedExpensesDialog: React.FC<Props> = ({
  visible,
  count,
  onContinue,
  onGoToExpenses,
  onCancel
}) => {
  const voce = count === 1 ? 'voce' : 'voci';
  const approvata = count === 1 ? 'approvata' : 'approvate';

  return (
    <Modal
      title={
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <ExclamationCircleFilled style={{ color: '#faad14', fontSize: 22 }} />
          <span>Attenzione: Voci di Spesa Non Approvate</span>
        </div>
      }
      open={visible}
      onCancel={onCancel}
      footer={[
        <Button key="cancel" onClick={onCancel}>
          Annulla
        </Button>,
        <Button key="continue" onClick={onContinue}>
          Continua Senza Includere
        </Button>,
        <Button key="expenses" type="primary" onClick={onGoToExpenses}>
          Vai alle Uscite
        </Button>
      ]}
      width={600}
    >
      <Alert
        message={
          <div>
            <p>
              Ci sono <strong>{count}</strong> {voce} di spesa non {approvata} fra le uscite 
              non visualizzate di seguito.
            </p>
            <p>
              Puoi continuare senza includere nel <strong>Rendiconto</strong>, o puoi tornare 
              alla sezione Uscite per verificare queste spese, eliminandole o approvandole.
            </p>
          </div>
        }
        type="warning"
        showIcon={false}
        style={{ marginBottom: 16 }}
      />
    </Modal>
  );
};

export default UnapprovedExpensesDialog;
```

## Example 7: Flutter/Dart Mobile Implementation

```dart
// lib/widgets/unapproved_expenses_dialog.dart

import 'package:flutter/material.dart';

class UnapprovedExpensesDialog extends StatelessWidget {
  final int count;
  final VoidCallback onContinue;
  final VoidCallback onGoToExpenses;

  const UnapprovedExpensesDialog({
    Key? key,
    required this.count,
    required this.onContinue,
    required this.onGoToExpenses,
  }) : super(key: key);

  String _getVoce() => count == 1 ? 'voce' : 'voci';
  String _getApprovata() => count == 1 ? 'approvata' : 'approvate';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Attenzione: Voci di Spesa Non Approvate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Container(
        constraints: BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ci sono $count ${_getVoce()} di spesa non ${_getApprovata()} '
                    'fra le uscite non visualizzate di seguito.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: 'Puoi continuare senza includere nel ',
                        ),
                        TextSpan(
                          text: 'Rendiconto',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ', o puoi tornare alla sezione Uscite per '
                              'verificare queste spese, eliminandole o approvandole.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Annulla'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onContinue();
          },
          child: Text('Continua Senza Includere'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onGoToExpenses();
          },
          child: Text('Vai alle Uscite'),
        ),
      ],
    );
  }

  static Future<void> show(
    BuildContext context, {
    required int count,
    required VoidCallback onContinue,
    required VoidCallback onGoToExpenses,
  }) {
    return showDialog(
      context: context,
      builder: (context) => UnapprovedExpensesDialog(
        count: count,
        onContinue: onContinue,
        onGoToExpenses: onGoToExpenses,
      ),
    );
  }
}
```

## Example 8: TypeScript Type Definitions

```typescript
// types/reports.ts

export interface UnapprovedExpense {
  id: string;
  amount: number;
  description: string;
  date: string;
  category: string;
  status: 'pending' | 'rejected';
}

export interface ReportValidation {
  hasUnapprovedExpenses: boolean;
  unapprovedCount: number;
  unapprovedExpenses: UnapprovedExpense[];
}

export interface ReportWarningProps {
  validation: ReportValidation;
  onContinueWithoutIncluding: () => void;
  onNavigateToExpenses: () => void;
}
```

## Example 9: Unit Test Example

```typescript
// __tests__/UnapprovedExpensesWarning.test.tsx

import { render, screen, fireEvent } from '@testing-library/react';
import UnapprovedExpensesWarning from '../UnapprovedExpensesWarning';

describe('UnapprovedExpensesWarning', () => {
  const mockOnContinue = jest.fn();
  const mockOnGoToExpenses = jest.fn();

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should display correct message with singular form', () => {
    render(
      <UnapprovedExpensesWarning
        count={1}
        onContinue={mockOnContinue}
        onGoToExpenses={mockOnGoToExpenses}
      />
    );

    expect(screen.getByText(/1 voce di spesa non approvata/i)).toBeInTheDocument();
  });

  it('should display correct message with plural form', () => {
    render(
      <UnapprovedExpensesWarning
        count={5}
        onContinue={mockOnContinue}
        onGoToExpenses={mockOnGoToExpenses}
      />
    );

    expect(screen.getByText(/5 voci di spesa non approvate/i)).toBeInTheDocument();
  });

  it('should mention "Rendiconto" not "Bilancio"', () => {
    render(
      <UnapprovedExpensesWarning
        count={3}
        onContinue={mockOnContinue}
        onGoToExpenses={mockOnGoToExpenses}
      />
    );

    expect(screen.getByText(/Rendiconto/i)).toBeInTheDocument();
    expect(screen.queryByText(/Bilancio/i)).not.toBeInTheDocument();
  });

  it('should call onContinue when continue button is clicked', () => {
    render(
      <UnapprovedExpensesWarning
        count={2}
        onContinue={mockOnContinue}
        onGoToExpenses={mockOnGoToExpenses}
      />
    );

    const continueButton = screen.getByText(/Continua Senza Includere/i);
    fireEvent.click(continueButton);

    expect(mockOnContinue).toHaveBeenCalledTimes(1);
  });

  it('should call onGoToExpenses when go to expenses button is clicked', () => {
    render(
      <UnapprovedExpensesWarning
        count={2}
        onContinue={mockOnContinue}
        onGoToExpenses={mockOnGoToExpenses}
      />
    );

    const expensesButton = screen.getByText(/Vai alle Uscite/i);
    fireEvent.click(expensesButton);

    expect(mockOnGoToExpenses).toHaveBeenCalledTimes(1);
  });
});
```

## Search and Replace Patterns

### Using grep to find the string
```bash
# Search for "Bilancio" in the context of reports
grep -rn "Bilancio" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" --include="*.vue" .

# Search for the specific phrase
grep -rn "Puoi continuare senza includere nel" .

# Search in JSON files (likely i18n)
find . -name "*.json" -exec grep -l "Bilancio" {} \;
```

### Using sed for replacement (be careful with this)
```bash
# Dry run - show what would change
grep -rn "Puoi continuare senza includere nel \*\*Bilancio\*\*" .

# Replace in specific file (after confirming the file)
sed -i 's/Puoi continuare senza includere nel \*\*Bilancio\*\*/Puoi continuare senza includere nel **Rendiconto**/g' path/to/file.tsx
```

## Migration Checklist

- [ ] Identify all files containing the message
- [ ] Backup original files
- [ ] Replace "Bilancio" with "Rendiconto" in the message
- [ ] Fix singular/plural forms if needed (1 voce vs N voci)
- [ ] Update any related constants or types
- [ ] Update i18n files if applicable
- [ ] Run tests to ensure no breaking changes
- [ ] Manual testing in the UI
- [ ] Check for any other instances of "Bilancio" that should be "Rendiconto"
- [ ] Update documentation if needed
