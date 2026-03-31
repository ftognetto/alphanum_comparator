# MYV-306: Rendiconti - Correzione Messaggio di Errore

## Overview
Correggere il messaggio di errore che appare quando ci sono voci di spesa non approvate nelle uscite non visualizzate. Il termine "Bilancio" deve essere sostituito con "Rendiconto".

## Current State
Il messaggio di errore attuale contiene:

```
Ci sono 1 voci di spesa non approvate fra le uscite non visualizzate di seguito. 
Puoi continuare senza includere nel **Bilancio**, o puoi tornare alla sezione 
Uscite per verificare queste spese, eliminandole o approvandole.
```

## Required Changes

### Messaggio Corretto
Il messaggio deve essere modificato come segue:

```
Ci sono 1 voci di spesa non approvate fra le uscite non visualizzate di seguito. 
Puoi continuare senza includere nel **Rendiconto**, o puoi tornare alla sezione 
Uscite per verificare queste spese, eliminandole o approvandole.
```

**Cambio richiesto:** `Bilancio` → `Rendiconto`

### Location
- **Sezione**: Rendiconti
- **Contesto**: Messaggio di errore/avviso per voci di spesa non approvate
- **Trigger**: Quando esistono voci di spesa non approvate nelle uscite non visualizzate

### Implementation Requirements

#### 1. Identificare la Stringa
Cercare nel codebase la stringa esatta o parti di essa:
- `"Bilancio"` nel contesto dei rendiconti
- `"Puoi continuare senza includere nel"`
- `"voci di spesa non approvate"`
- `"tornare alla sezione Uscite"`

#### 2. Possibili Posizioni
La stringa potrebbe trovarsi in:
- File di componenti React/Vue/Angular per la sezione Rendiconti
- File di traduzione/i18n (se l'applicazione usa internazionalizzazione)
- File di messaggi di errore centralizzati
- Costanti o file di configurazione
- Template HTML

#### 3. Verificare il Plurale
Il messaggio mostra `"1 voci"` che grammaticalmente dovrebbe essere `"1 voce"` (singolare) o `"2 voci"` (plurale). Verificare se questo è un problema separato o se il sistema gestisce dinamicamente il numero.

## Technical Implementation Notes

### Scenario 1: Stringa Hardcoded
Se la stringa è hardcoded nel componente:

```javascript
// Prima
const message = `Ci sono ${count} voci di spesa non approvate fra le uscite non visualizzate di seguito. 
Puoi continuare senza includere nel **Bilancio**, o puoi tornare alla sezione 
Uscite per verificare queste spese, eliminandole o approvandole.`;

// Dopo
const message = `Ci sono ${count} voci di spesa non approvate fra le uscite non visualizzate di seguito. 
Puoi continuare senza includere nel **Rendiconto**, o puoi tornare alla sezione 
Uscite per verificare queste spese, eliminandole o approvandole.`;
```

### Scenario 2: File di Traduzione (i18n)
Se usa un sistema di internazionalizzazione:

```json
// locales/it.json
{
  "reports": {
    "errors": {
      "unapproved_expenses": "Ci sono {count} voci di spesa non approvate fra le uscite non visualizzate di seguito. Puoi continuare senza includere nel **Rendiconto**, o puoi tornare alla sezione Uscite per verificare queste spese, eliminandole o approvandole."
    }
  }
}
```

### Scenario 3: Costanti
Se le stringhe sono in un file di costanti:

```javascript
// constants/messages.js
export const MESSAGES = {
  UNAPPROVED_EXPENSES_WARNING: (count) => 
    `Ci sono ${count} voci di spesa non approvate fra le uscite non visualizzate di seguito. 
    Puoi continuare senza includere nel **Rendiconto**, o puoi tornare alla sezione 
    Uscite per verificare queste spese, eliminandole o approvandole.`
};
```

## Search Strategy

### Comandi di Ricerca Consigliati

```bash
# Cerca "Bilancio" in tutto il progetto
grep -r "Bilancio" .

# Cerca la frase specifica
grep -r "Puoi continuare senza includere nel" .

# Cerca "voci di spesa non approvate"
grep -r "voci di spesa non approvate" .

# Cerca in file specifici (JavaScript/TypeScript)
find . -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" | xargs grep -l "Bilancio"

# Cerca in file di traduzione
find . -name "*.json" | xargs grep -l "Bilancio"
```

## Testing Checklist

- [ ] Verificare che il messaggio sia stato modificato correttamente
- [ ] Confermare che "Bilancio" sia stato sostituito con "Rendiconto"
- [ ] Testare che il messaggio appaia correttamente quando ci sono voci di spesa non approvate
- [ ] Verificare che la formattazione markdown (\*\*Rendiconto\*\*) funzioni correttamente
- [ ] Controllare che non ci siano altri riferimenti a "Bilancio" che dovrebbero essere "Rendiconto" nel contesto dei rendiconti
- [ ] Testare su tutti i ruoli utente (Coordinamento, Associazione, Regione)
- [ ] Verificare su desktop e mobile

## Additional Considerations

### Terminologia
- **Bilancio**: Documento contabile preventivo o consuntivo generale
- **Rendiconto**: Documento che riporta in modo dettagliato le entrate e le uscite di un'attività specifica o evento

Nel contesto di MyVOL V2, quando si gestiscono spese relative a eventi o attività specifiche, il termine corretto è "Rendiconto" piuttosto che "Bilancio".

### Possibili Altre Occorrenze
Verificare se ci sono altri messaggi o label nella sezione Rendiconti che usano erroneamente "Bilancio" invece di "Rendiconto".

## Files Likely to be Modified

Based on typical web application structure:
- Components/Pages per la sezione Rendiconti
- File di messaggi di errore/avviso
- File di traduzione (locales/it.json o simili)
- Costanti dell'applicazione
- Possibilmente componenti condivisi per la gestione delle spese

## Related Issues
- Issue: MYV-306
- Project: MyVOL V2
- Module: Rendiconti > Messaggio di Errore
