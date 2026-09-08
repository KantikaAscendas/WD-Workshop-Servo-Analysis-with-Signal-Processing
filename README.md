# WD Workshop: Servo Analysis with Signal Processing

Participant materials for a MATLAB-based technical workshop covering servo-data analysis, interactive engineering apps, control-system analysis, App Designer, and an introductory Agentic AI workflow.

The examples use educational sample data and illustrative models. They are not validated models of a Western Digital product and must not be used for engineering decisions without appropriate data, requirements, and verification.

## Workshop topics

- Import and inspect servo or FA measurement data from CSV files
- Explore time-domain and frequency-domain behavior with Signal Analyzer
- Investigate digital-filter options with Filter Designer
- Compare dynamic responses with Linear System Analyzer
- Explore controller tuning with PID Tuner and Control System Designer
- Build maintainable MATLAB applications with App Designer
- Use MATLAB Agentic Toolkit and MATLAB skills with structured engineering prompts

Simulink and Simscape are not required for the workshop exercises in this repository.

## Software requirements

### Core workshop

- MATLAB R2026a recommended
- Signal Processing Toolbox
- Control System Toolbox

### Optional exercise

- Statistics and Machine Learning Toolbox for the machine-learning prompt lab

The Agentic AI exercise also requires Git, a supported AI coding agent, the account or subscription required by that agent, and internet access. Corporate proxy or security policies may require assistance from your IT team.

## Workshop files

| File | Purpose |
| --- | --- |
| `sample_servo_data.csv` | Educational sample data used by the servo exercises |
| `WD_Servo_Signal_Control_Workshop.m` | App-first signal-processing and control workshop Live Script |
| `WDSignalExplorer.mlapp` | Example App Designer application for CSV signal exploration |
| `WD_Agentic_AI_Toolkit_and_Skills_Workshop.m` | Toolkit installation, connection checks, and guided AI prompt labs |

Additional presenter or internal preparation files may not be included in the participant repository.

## Getting started

Clone or download this repository:

```bash
git clone https://github.com/KantikaAscendas/WD-Workshop-Servo-Analysis-with-Signal-Processing.git
cd WD-Workshop-Servo-Analysis-with-Signal-Processing
```

Then:

1. Start MATLAB.
2. Set the repository folder as the MATLAB Current Folder.
3. Confirm that `sample_servo_data.csv` is visible.
4. Open `WD_Servo_Signal_Control_Workshop.m` in the Live Editor.
5. Run one section at a time and follow the instructions for each MATLAB app.

Do not change the supplied CSV during the workshop. Save participant-generated files with a new name.

## MATLAB Agentic Toolkit setup

Use the current instructions from the official [MATLAB Agentic Toolkit repository](https://github.com/matlab/matlab-agentic-toolkit):

1. Download `agenticToolkitInstaller.mltbx` from the official repository.
2. Open the `.mltbx` file in MATLAB and approve the add-on installation.
3. Run the following command in the MATLAB Command Window:

   ```matlab
   setupAgenticToolkit("install")
   ```

4. Select your AI coding agent and only the skill groups required for the workshop.
5. Follow the agent-specific configuration steps displayed by the installer.

Recommended skill groups:

- `matlab-core`
- `matlab-data-import-and-analysis`
- `signal-processing`
- `matlab-app-building`
- `control-systems`
- `ai-and-statistics` — optional, for the machine-learning exercise

Installing only relevant skill groups helps the AI agent select the intended skill more reliably.

To connect a configured AI agent to an existing MATLAB session, run:

```matlab
shareMATLABSession()
```

The participant Live Script keeps installation and session sharing disabled by default so that **Run All** cannot start either action accidentally.

## First Agentic AI prompt

After connecting the agent, begin with a read-only environment check:

> Use the connected MATLAB session to report the MATLAB release and list the installed products. Confirm whether Signal Processing Toolbox, Control System Toolbox, and Statistics and Machine Learning Toolbox are available. List the installed MATLAB skills relevant to signal processing, app building, machine learning, and control systems. Do not install anything and do not create or modify files yet.

The Agentic AI Live Script contains guided prompts for:

- Preparing and analyzing servo signals
- Investigating digital-filter designs
- Building an editable App Designer application
- Creating an optional educational classification workflow
- Comparing an illustrative plant and PID controller using Control System Toolbox
- Reviewing AI-generated MATLAB files before accepting changes

## Prompt-writing checklist

For useful and reviewable results, include:

1. **Context** — data, folder, and engineering situation
2. **Goal** — the expected technical outcome
3. **Skill and products** — name the MATLAB skill and allowed toolboxes
4. **Constraints** — protect source files and exclude unavailable products
5. **Deliverable and verification** — specify the output and ask the agent to run or test it

If a skill does not activate automatically, explicitly write: `Use the <skill-name> skill to ...`

## Data and AI safety

- Use only the supplied educational data during the workshop.
- Do not upload confidential customer data, credentials, access tokens, license numbers, proprietary source code, or unreleased product information.
- Review proposed tool calls before approval, particularly file writes, installations, and shell commands.
- Treat generated analysis and code as a reviewable draft.
- Verify units, assumptions, toolbox dependencies, numerical results, and engineering conclusions.
- A qualified engineer remains responsible for final technical decisions.

## Official resources

- [MATLAB Agentic Toolkit product page](https://www.mathworks.com/products/matlab-agentic-toolkit.html)
- [MATLAB Agentic Toolkit GitHub repository](https://github.com/matlab/matlab-agentic-toolkit)
- [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html)
- [Control System Toolbox](https://www.mathworks.com/products/control.html)
- [App Designer](https://www.mathworks.com/products/matlab/app-designer.html)

## Support during the workshop

If an exercise does not run as expected, record:

- MATLAB release
- Installed products
- The Live Script section being run
- The complete error message
- Whether the sample CSV was modified or moved

This information will help the presenter diagnose the issue efficiently.
