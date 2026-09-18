# WD Workshop: Signal Data Analysis & App Development with MATLAB

Participant materials for a hands-on MATLAB workshop in two parts:

- **Part 1 — Manual, app-first lab.** Import a CSV, prepare the signal with Live Editor tasks, explore it in Signal Analyzer, and hand the result to an App Designer app. Every step is point-and-click; MATLAB generates the code for you.
- **Part 2 — Agentic AI.** Give the same task to an AI coding agent connected to MATLAB through the MATLAB Agentic Toolkit: analyze the signal with MATLAB skills, package the approved analysis as a tested function, build an App Designer app around it, extend the app with a predictive machine-learning model, and review the result.

All data in this repository is **synthetic teaching data**. It is not measured Western Digital data, it contains no rotation reference (so no RRO/NRRO separation), and none of the numbers are acceptance criteria. Do not use these files for engineering decisions.

## Software requirements

| Requirement | Part 1 lab | Part 2 Agentic AI |
| --- | --- | --- |
| MATLAB **R2025a or newer** (the lab is a plain-text `.m` Live Script) | Required | Required |
| Signal Processing Toolbox (Signal Analyzer, Filter Designer) | Required | Required |
| Statistics and Machine Learning Toolbox | – | Lab D (predictive model) only |
| Git, a supported AI coding agent and its account, internet access | – | Required |

Corporate proxy or security policies may require help from your IT team for Part 2 Agentic AI

## Files in this folder

| File | Used in | Purpose |
| --- | --- | --- |
| `WD_Labfile_Signal_Data_Analysis_App_Development.m` | Part 1 | The lab. Open it in the Live Editor and run one section at a time |
| `WD_Lab_Signal_Data.csv` | Part 1 | Input data for the **Import Data** task: `Time_s`, `Reference_um`, `Evaluation_um` (4096 rows at 2000 Hz) |
| `WD_Lab_Signal_Data.xlsx` | Part 1 (optional) | The same data as an Excel workbook (sheet `Signal`), for teams that prefer Excel |
| `WDSignalExplorer.mlapp` | Part 1, step 10 | Example App Designer app that loads a CSV, plots time/frequency views, reports RMS and peak-to-peak, and exports a processed CSV |
| `WD_Agentic_AI_Toolkit_and_Skills_Workshop.m` | Part 2 | Toolkit installation, connection check, prompt Labs A–E, and a review step |

Files you create during the workshop (for example `WD_Lab_Prepared_Signal.csv` and your saved `.mlx`) are written next to these files. Do not modify the supplied CSV/XLSX; save your own results under new names.

## Getting started

```bash
git clone https://github.com/KantikaAscendas/WD-Workshop-Servo-Analysis-with-Signal-Processing.git
```

1. Copy the folder to your local disk (do not run it from a USB stick or a network drive).
2. Start MATLAB and set the folder as the **Current Folder**.
3. Open `WD_Labfile_Signal_Data_Analysis_App_Development.m` in the Live Editor.
4. Run **section 0**. It must list `WD_Lab_Signal_Data.csv` and `WDSignalExplorer.mlapp`.
5. Work through the sections in order with **Run Section** (do not use Run All).

If MATLAB opens the file as plain code and you see lines starting with `%[text]`, your release is older than R2025a. Ask the instructor for the `.mlx` version.

## Part 1 — Lab overview

Each section tells you what to click and what you should see. Code lines starting with `% ▶` mark where to insert a Live Task: click the line, then **Live Editor → Task**, or type the task name on the line and pick it from the suggestions.

| Step | Live Task / App | What you do | Output variable |
| --- | --- | --- | --- |
| 0 | – | Check the Current Folder | – |
| 1 | **Import Data** | Import the CSV as column vectors | `Time_s`, `Reference_um`, `Evaluation_um` |
| 2 | **Create Plot** | Plot `Evaluation_um` vs `Time_s`; spot gaps, spikes and drift | – |
| 3 | **Clean Missing Data** | Fill missing, linear interpolation, X-axis `Time_s` | `filledData` |
| 4 | **Clean Outlier Data** | Fill outliers, moving median, window 101 | `noOutlierData` |
| 5 | **Find and Remove Trends** | Linear trend | `detrendedData` |
| 6 | **Smooth Data** | Savitzky-Golay, window 11 (experiment with 31) | `smoothedData` |
| 7 | – | Before/after plot | – |
| 8 | **Signal Analyzer** | Compare Reference, EvaluationClean and EvaluationSmoothed in time and spectrum views; generate a function | – |
| 9 | **Filter Designer** (optional) | Specify a lowpass filter (Fs 2000 Hz, Fpass 300, Fstop 400) and generate code | – |
| 10 | **WD Signal Explorer** | Save `WD_Lab_Prepared_Signal.csv`, load it in the app, inspect the app code | `preparedData` |
| 11 | – | Save As `.mlx` with your name | – |

Use the output names exactly as listed (case-sensitive); later sections depend on them.

### About the data

`WD_Lab_Signal_Data.csv` holds one synthetic Reference/Evaluation pair sampled at 2000 Hz for 2.048 s. Both channels contain a 120 Hz component, a smaller 250 Hz component and random noise; the Evaluation channel has larger amplitudes at both frequencies. To practise preprocessing, the Evaluation channel additionally contains:

- a slow linear drift of about 1.5 µm over the record,
- four short gaps (24 empty cells, which become `NaN` on import),
- four impulse spikes of about ±7–8 µm.

The Reference channel is left clean. With the settings in the lab, the Clean Missing Data task should report 24 filled entries and the Clean Outlier Data task should fill 4 outliers.

## Part 2 — Agentic AI

Open `WD_Agentic_AI_Toolkit_and_Skills_Workshop.m` after finishing Part 1. The script keeps installation and session sharing switched off by default so that **Run All** cannot start them by accident.

### Install the MATLAB Agentic Toolkit

Follow the current instructions in the official [MATLAB Agentic Toolkit repository](https://github.com/matlab/matlab-agentic-toolkit):

1. Download `agenticToolkitInstaller.mltbx` from the repository.
2. Open the `.mltbx` file in MATLAB and approve the add-on installation.
3. In the MATLAB Command Window run:

   ```matlab
   setupAgenticToolkit("install")
   ```

4. Select your AI coding agent and only the skill groups needed for this workshop: `matlab-core`, `matlab-data-import-and-analysis`, `signal-processing`, `matlab-app-building`, and `ai-and-statistics` for Lab D.
5. Follow the agent-specific steps shown by the installer.

To connect a configured agent to the running MATLAB session:

```matlab
shareMATLABSession()
```

### First prompt: read-only environment check

> Use the connected MATLAB session to report the MATLAB release and list the installed products. Confirm whether Signal Processing Toolbox is available. List the installed MATLAB skills relevant to signal processing and app building. Do not install anything and do not create or modify files yet.

### Guided prompt labs

The Part 2 script contains ready-to-copy prompts. Each one names the MATLAB skills to use, protects the supplied files, and asks the agent to wait for approval before changing an assumption. All agent output goes to a new `agent_output` folder.

| Lab | Skills | What the agent produces |
| --- | --- | --- |
| A — Inspect and analyze | `matlab-prepare-signal-data`, `matlab-analyze-time-frequency-content` | Data-quality report, approved preprocessing, Welch PSD and metrics comparing Evaluation with Reference (`labA_signal_analysis.m`) |
| B — Tested function | `matlab-write-test` | `prepareWDSignal.m`, `analyzeWDSignal.m` and a unit-test class that passes in MATLAB |
| C — App Designer app | `matlab-build-app`, `matlab-build-chart` | `WDSignalAnalyzerApp.mlapp` that calls the Lab B functions: load CSV, prepare, time/spectrum views, metrics, export |
| D — Predictive model | `matlab-extract-signal-features`, `matlab-classify-tabular-data` | Window features, a trained classifier for the two synthetic conditions, and a Predict button added to the app (`labD_machine_learning.m`) |
| E — Optional filter | `matlab-design-digital-filter` | Two compared filter designs with a justification of what is preserved (`labE_filter_design.m`) |
| Review | `matlab-review-code` | Must fix / Should improve / Optional findings for everything in `agent_output` |

The Lab D labels are the two synthetic conditions in the sample file (Reference vs Evaluation). They are not fault labels, and the reported accuracy is a teaching result only.

### Prompt-writing checklist

1. **Context** — data file, folder and engineering situation
2. **Goal** — the expected technical outcome
3. **Skill and products** — name the MATLAB skill and the allowed toolboxes
4. **Constraints** — protect source files, exclude unavailable products
5. **Deliverable and verification** — name the output file and ask the agent to run or test it

If a skill does not activate automatically, write explicitly: `Use the <skill-name> skill to ...`

## Data and AI safety

- Use only the supplied synthetic data during the workshop.
- Do not upload confidential customer data, credentials, tokens, license numbers, proprietary source code or unreleased product information to any AI service.
- Review proposed tool calls before approving them, especially file writes, installations and shell commands.
- Treat generated analysis and code as a reviewable draft; verify units, sample rate, assumptions, toolbox dependencies and numerical results.
- A qualified engineer remains responsible for the final technical decision.

## Troubleshooting

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| Section 0 reports the files are not found | Wrong Current Folder | Open the workshop folder in the Current Folder panel |
| `%[text]` lines are visible as plain comments | MATLAB older than R2025a | Use the `.mlx` version from the instructor |
| A task shows no variables to select | The previous section has not been run | Run the earlier sections first |
| `Unrecognized function or variable 'detrendedData'` | Output name differs from the lab, or the task has not run | Rename the task output exactly as listed |
| Vector sizes do not match in step 7 | *Remove* was chosen instead of *Fill* in step 3 or 4 | Switch the task back to Fill |
| Signal Analyzer spectrum is empty | A signal containing `NaN` was sent to the app | Use `detrendedData`/`smoothedData`, not the raw import |
| `WDSignalExplorer` does not open | Current Folder is not this folder | Return to section 0 |

When asking for help, record the MATLAB release, installed products, the section you were running, the complete error message, and whether the CSV was modified or moved.

## Official resources

- [Live Editor Tasks](https://www.mathworks.com/help/matlab/live-editor-tasks.html)
- [Signal Analyzer](https://www.mathworks.com/help/signal/ref/signalanalyzer-app.html)
- [Filter Designer](https://www.mathworks.com/help/signal/ref/filterdesigner-app.html)
- [App Designer](https://www.mathworks.com/help/matlab/app-designer.html)
- [MATLAB Agentic Toolkit](https://www.mathworks.com/products/matlab-agentic-toolkit.html) · [GitHub repository](https://github.com/matlab/matlab-agentic-toolkit)
