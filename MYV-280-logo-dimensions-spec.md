# MYV-280: Logo Dimension Guidelines Implementation

## Overview
Add pixel dimension examples to the logo upload functionality in the settings menu (Impostazioni > Generali > Logo).

## Current State
The logo upload interface currently shows aspect ratio guidance (e.g., 1:1, 2:1) but lacks concrete pixel dimension examples.

## Required Changes

### Location
- Menu: Impostazioni (Settings)
- Section: Generali (General)
- Tab: Logo

### Implementation Requirements

#### 1. Add Pixel Dimension Examples
Add visual guidance showing recommended pixel dimensions alongside existing aspect ratio information.

**Recommended Dimensions:**
- **Square Logo (1:1)**: 200px × 200px or 300px × 300px
- **Horizontal Logo (2:1)**: 300px × 150px or 400px × 200px
- **Horizontal Logo (3:1)**: 300px × 100px or 600px × 200px

#### 2. Display Format
The guidance should be displayed in a user-friendly format, for example:

```
Dimensioni consigliate:
- Logo quadrato (1:1): 200px × 200px o 300px × 300px
- Logo orizzontale (2:1): 300px × 150px o 400px × 200px  
- Logo orizzontale (3:1): 300px × 100px o 600px × 200px

Formato: PNG, JPG, SVG
Dimensione massima file: 2MB
```

Or in English:
```
Recommended dimensions:
- Square logo (1:1): 200px × 200px or 300px × 300px
- Horizontal logo (2:1): 300px × 150px or 400px × 200px
- Horizontal logo (3:1): 300px × 100px or 600px × 200px

Format: PNG, JPG, SVG
Maximum file size: 2MB
```

#### 3. UI/UX Considerations
- Display the guidance near the file upload button
- Use a help icon (?) or info icon (ℹ️) that shows a tooltip with the dimensions
- Consider showing a small preview of the aspect ratios visually
- Ensure the text is visible but not intrusive

#### 4. Technical Implementation Notes

**Frontend Changes Required:**
1. Locate the logo upload component (likely in a settings/general component)
2. Add a help text or tooltip component
3. Include the pixel dimension examples in Italian (primary language)
4. Ensure responsive design on mobile devices

**Validation (Optional Enhancement):**
- Consider adding client-side validation to warn users if uploaded image doesn't match recommended dimensions
- Show actual dimensions of uploaded image
- Allow upload regardless of dimensions (warning only, not blocking)

## Testing Checklist
- [ ] Dimension guidance is visible on the logo upload page
- [ ] Text is properly localized (Italian)
- [ ] Guidance is readable on desktop
- [ ] Guidance is readable on mobile devices
- [ ] Help icon/tooltip works correctly
- [ ] Doesn't interfere with actual upload functionality
- [ ] Displays correctly for all user roles (Coordinamento, Associazione, Regione)

## Files Likely to be Modified
Based on typical web application structure:
- Settings/General component (React/Vue/Angular component)
- Logo upload form component
- Possibly a shared constants file for dimension specifications
- Language/translation files for Italian strings

## Related Issues
- Issue: MYV-280
- Project: MyVOL V2
- Module: Settings > General > Logo
