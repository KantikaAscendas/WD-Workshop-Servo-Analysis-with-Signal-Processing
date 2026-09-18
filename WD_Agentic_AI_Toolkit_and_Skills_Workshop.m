%[text] # WD Agentic AI Workshop: MATLAB Agentic Toolkit and Skills
%[text] **Part 2 | From the manual lab to an agent-assisted workflow: signal analysis → reviewed function → App Designer app → predictive machine learning**
%[text] In Part 1 you prepared `WD_Lab_Signal_Data.csv` by hand with Live Tasks, Signal Analyzer and an App Designer app. In this part an AI coding agent, connected to your local MATLAB through the MATLAB Agentic Toolkit, does the same kind of work from a written prompt. MATLAB skills guide the agent; MATLAB executes the code; you set the goal and review the evidence.
%[text:tableOfContents]{"heading":"Workshop flow"}
%[text] **How every prompt section works:** Run the section → the prompt text is displayed → copy it into your AI agent → read the agent's plan and answer its questions → approve only actions inside the stated scope → come back to MATLAB and check the code, plots and numbers. Running a section by itself does not send anything to the agent.
%[text] **Data note:** all files are synthetic teaching data. They are not WD measurements, they contain no rotation reference (no RRO/NRRO), and no number here is an acceptance criterion. Never paste confidential data, credentials, license numbers or proprietary code into an AI service.
%[text] - Check the local MATLAB environment and connect the agent
%[text] - Lab A — inspect and analyze the signal with signal-processing skills
%[text] - Lab B — turn the approved analysis into a tested MATLAB function
%[text] - Lab C — build an App Designer app around that function
%[text] - Lab D — extend the app with a predictive machine-learning model
%[text] - Lab E — optional: justify a digital filter
%[text] - Review the agent's work before accepting it \
%%
%[text] ## 1. What you need
%[text] - MATLAB R2025a or newer with Signal Processing Toolbox (Statistics and Machine Learning Toolbox for Lab D)
%[text] - Git, a supported MCP-capable AI coding agent, and the account or subscription it requires
%[text] - Internet access for the installer and the AI provider; corporate proxy settings may need IT support
%[text] - This workshop folder on a local disk, with `WD_Lab_Signal_Data.csv`, `WDSignalExplorer.mlapp` and, if you finished Part 1, `WD_Lab_Prepared_Signal.csv` \
%[text] Official resources: [MATLAB Agentic Toolkit](https://www.mathworks.com/products/matlab-agentic-toolkit.html) · [GitHub repository and setup guide](https://github.com/matlab/matlab-agentic-toolkit)
%%
%[text] ## 2. Check this folder and the installed products
%[text] Run this section first. It reports the products used by the labs and confirms the data files are next to this script.
workshopFile = which('WD_Agentic_AI_Toolkit_and_Skills_Workshop');
if strlength(workshopFile) == 0
    workshopFolder = string(pwd);
else
    workshopFolder = string(fileparts(workshopFile));
end
installedProductInfo = ver;
installedProducts = string({installedProductInfo.Name})';
productsToCheck = ["MATLAB"; "Signal Processing Toolbox"; "Statistics and Machine Learning Toolbox"];
isInstalled = arrayfun(@(productName) any(strcmpi(installedProducts, productName)), productsToCheck);
environmentCheck = table(productsToCheck, isInstalled, VariableNames={'Product','Installed'})
filesToCheck = ["WD_Lab_Signal_Data.csv"; "WDSignalExplorer.mlapp"; "WD_Lab_Prepared_Signal.csv"];
fileCheck = table(filesToCheck, isfile(fullfile(workshopFolder, filesToCheck)), VariableNames={'File','Found'})
%%
%[text] ## 3. Install the MATLAB Agentic Toolkit
%[text] 1. Download `agenticToolkitInstaller.mltbx` from the official GitHub repository.
%[text] 2. Open the `.mltbx` file in MATLAB and approve the add-on installation.
%[text] 3. Run `setupAgenticToolkit("install")` in the Command Window.
%[text] 4. Select your AI agent and only the skill groups needed today: `matlab-core`, `matlab-data-import-and-analysis`, `signal-processing`, `matlab-app-building`, and `ai-and-statistics` for Lab D.
%[text] 5. Complete the agent-specific configuration shown by the installer. \
%[text] Installing only the relevant skill groups helps the agent pick the intended skill. The switch below is `false` on purpose so that **Run All** cannot start an installation; set it to `true` and run only this section when the instructor asks.
runToolkitInstaller = false;
if runToolkitInstaller
    setupAgenticToolkit("install")
else
    disp("Installation skipped. Change runToolkitInstaller to true only when ready.")
end
%%
%[text] ## 4. Connect the agent to this MATLAB session
%[text] `shareMATLABSession()` lets the configured agent use this MATLAB session, including the Current Folder and workspace. Review every proposed tool action before approving it, especially file writes, installations and shell commands. Set the switch to `true` and run only this section when instructed.
shareCurrentMATLABSession = false;
if shareCurrentMATLABSession
    shareMATLABSession()
else
    disp("MATLAB session sharing skipped. Enable it only when you are ready to connect.")
end
%%
%[text] ## 5. Verify the connection (read-only prompt)
%[text] The first prompt changes nothing. Compare the agent's answer with the table from section 2: the agent must separate installed from licensed products and must not guess skill names.
connectionCheckPrompt = join([ ...
    "Use the connected MATLAB session to report the MATLAB release and list the installed products." ...
    "Confirm whether Signal Processing Toolbox and Statistics and Machine Learning Toolbox are installed and licensed." ...
    "List the installed MATLAB skills relevant to signal processing, app building and machine learning, with their exact names." ...
    "Report the current folder and confirm that WD_Lab_Signal_Data.csv is present." ...
    "Do not install anything and do not create or modify any file."], newline);
disp(connectionCheckPrompt)
%%
%[text] ## 6. A prompt with clear boundaries
%[text] Every prompt in this lab has the same five parts:
%[text] 1. **Context** — the data file, its units, and the engineering question
%[text] 2. **Goal** — the result you want, not just a command
%[text] 3. **Skills and products** — name the skill you want to trigger and the toolboxes the solution may use
%[text] 4. **Constraints** — protect source files, ask before changing assumptions, no unavailable products
%[text] 5. **Deliverable and verification** — the output files, and a request to run or test them \
%[text] If a skill does not trigger by itself, write it explicitly: **Use the `<skill-name>` skill to ...**
%%
%[text] ## 7. Lab A — inspect and analyze the signal with skills
%[text] **What the agent should do:** inspect data quality → confirm units and sampling → propose preprocessing and wait → compute spectra and metrics → compare Evaluation with Reference → save code, settings and figures in a new folder. This is the same workflow you performed manually in Part 1.
%[text] **Check before accepting:** the sample rate is 2000 Hz; 24 missing values and 4 outliers are reported; the Evaluation spectrum shows peaks near 120 Hz and 250 Hz that are higher than the Reference; the source CSV is unchanged.
signalAnalysisPrompt = join([ ...
    "Use the matlab-prepare-signal-data and matlab-analyze-time-frequency-content skills." ...
    "Context: WD_Lab_Signal_Data.csv in the current folder contains Time_s (seconds), Reference_um and Evaluation_um (position error in micrometers) from one synthetic test record. The Evaluation channel contains gaps, impulse spikes and slow drift." ...
    "Goal: explain what changed between Evaluation and Reference in the time and frequency domains." ...
    "Step 1: inspect the columns, infer the sample rate from Time_s, and report missing values, duplicate or nonuniform timestamps and outliers. Confirm the units with me." ...
    "Step 2: propose a preprocessing plan (fill missing, fill outliers, remove trend) with the parameters you intend to use, then WAIT for my approval before computing anything else. For reference, the manual workflow used linear interpolation, a moving-median outlier filter with a 101-sample window and threshold 3, and linear detrending." ...
    "Step 3: after approval, compute a Welch PSD (Hann window 1024, 50 percent overlap, NFFT 2048) for both channels, report RMS, peak-to-peak and the two strongest spectral peaks with units, and compare Evaluation with Reference." ...
    "Constraints: use only MATLAB and Signal Processing Toolbox. Do not modify WD_Lab_Signal_Data.csv or any supplied file. Do not describe these synthetic signals as a drive diagnosis or as RRO/NRRO." ...
    "Deliverable: create a new folder agent_output and save a plain-text Live Script agent_output/labA_signal_analysis.m plus the figures and a settings summary. Run the script, fix any error, and finish with a short findings-and-limitations summary."], newline);
disp(signalAnalysisPrompt)
%%
%[text] ## 8. Lab B — turn the approved analysis into a tested function
%[text] **Why:** an app should call a reviewed analysis function, not carry its own copy of the processing code. Testing the function first makes the app in Lab C easy to trust.
%[text] **Check before accepting:** the function signature is documented; the tests pass in MATLAB; the results for `WD_Lab_Signal_Data.csv` match Lab A and your Part 1 numbers.
analysisFunctionPrompt = join([ ...
    "Use the matlab-write-test skill together with the approved processing settings from Lab A." ...
    "Create agent_output/prepareWDSignal.m: a function [cleanSignal, info] = prepareWDSignal(time_s, signal_um, options) that fills missing values by linear interpolation using the time vector, fills outliers with a moving-median detector (default window 101 samples, threshold 3), removes a linear trend, and returns counts of filled and replaced samples in info." ...
    "Create agent_output/analyzeWDSignal.m: a function metrics = analyzeWDSignal(time_s, signal_um) that returns RMS, peak-to-peak, the Welch PSD (Hann 1024, 50 percent overlap, NFFT 2048) and the two strongest peaks in Hz, all clearly labeled with units." ...
    "Add input validation with arguments blocks and error messages a user can act on." ...
    "Create agent_output/testWDSignalFunctions.m, a class-based unit test that checks: no NaN remains after preparation, the signal length is preserved, the trend is removed, and the dominant peak for WD_Lab_Signal_Data.csv Evaluation_um is within 2 Hz of 120 Hz." ...
    "Run the tests with the MATLAB test tool, fix failures, and report the results. Use only MATLAB and Signal Processing Toolbox and do not modify any supplied file."], newline);
disp(analysisFunctionPrompt)
%%
%[text] ## 9. Lab C — build an App Designer app around the function
%[text] **Why:** this is the step that turns today's analysis into a tool a colleague can use. The agent builds the app; you test every control and compare its numbers with the Live Script.
%[text] **Check before accepting:** the app opens and loads `WD_Lab_Signal_Data.csv`; RMS and peak-to-peak for the prepared Evaluation channel match Part 1 (about 0.96 um and 3.97 um); callbacks are short and call `prepareWDSignal` / `analyzeWDSignal`; `WDSignalExplorer.mlapp` is untouched.
appDesignerPrompt = join([ ...
    "Use the matlab-build-app and matlab-build-chart skills." ...
    "Build an editable App Designer app agent_output/WDSignalAnalyzerApp.mlapp that reuses agent_output/prepareWDSignal.m and agent_output/analyzeWDSignal.m. Do not copy the processing code into the app." ...
    "Inputs: a Load CSV button, drop-downs for the time column and the signal column populated from the numeric variables of the file, a Prepare signal check box, and a Compare with reference drop-down that may be set to none." ...
    "Views: a time plot and a spectrum plot side by side, a metrics table with units, and an Export button that writes the prepared signal and the metrics to new CSV files that never overwrite an existing file." ...
    "Structure: uigridlayout for resizing, private properties for raw and prepared data, thin callbacks, and private methods for loading, validation, updating plots and updating metrics. Show a clear message when the file has no numeric time column." ...
    "First summarize the component layout and callback flow in five bullets and wait for my approval. Then implement the app, run it, load WD_Lab_Signal_Data.csv with Time_s and Evaluation_um, test the main controls, fix errors, and report the files created." ...
    "Use only MATLAB and Signal Processing Toolbox. Do not overwrite WDSignalExplorer.mlapp or any supplied file."], newline);
disp(appDesignerPrompt)
%%
%[text] ## 10. Lab D — extend the app with a predictive machine-learning model
%[text] **Why:** once features and metrics are computed by a trusted function, the same pipeline can feed a classifier. The demonstration predicts whether a signal window looks like the Reference or the Evaluation condition; with real, engineer-labeled data the same workflow would predict a real condition of interest.
%[text] **Check before accepting:** the agent verified the toolbox first; the labels are described as the two synthetic conditions, not as fault labels; the train/test split has no window overlap leakage; the reported accuracy is presented as a teaching result with its limitations.
%[text] Run this lab only if section 2 reports **Statistics and Machine Learning Toolbox = true**.
machineLearningPrompt = join([ ...
    "Use the matlab-extract-signal-features and matlab-classify-tabular-data skills. First verify that Statistics and Machine Learning Toolbox is installed and licensed; if not, stop and explain which product is required." ...
    "Context: WD_Lab_Signal_Data.csv contains two synthetic conditions, Reference_um and Evaluation_um, sampled at 2000 Hz. Prepare both channels with agent_output/prepareWDSignal.m before extracting features." ...
    "Step 1: split each prepared channel into non-overlapping windows of 256 samples and compute interpretable features per window: RMS, peak-to-peak, crest factor, dominant frequency, and band power around 120 Hz and 250 Hz. Label each window Reference or Evaluation. State clearly that these labels are synthetic conditions, not WD fault labels." ...
    "Step 2: use a reproducible train/test split that keeps windows from overlapping between sets, compare at least two simple models (for example a decision tree and a linear SVM) with cross-validation, and report a confusion matrix and accuracy with its uncertainty. Explain how Classification Learner could be used interactively with the same feature table." ...
    "Step 3: save the best model as agent_output/wdConditionModel.mat together with the feature-extraction code as agent_output/extractWDFeatures.m, and add a Predict button to agent_output/WDSignalAnalyzerApp.mlapp that loads the model and shows the predicted condition and confidence for the currently loaded signal, window by window." ...
    "If the instructor provides sample_wd_grouped_signal_data.csv with several DriveID/Head/Cylinder records, use whole records for the split instead of windows from one record and explain why that is more realistic." ...
    "Deliverable: agent_output/labD_machine_learning.m as a plain-text Live Script that runs end to end. Summarize assumptions, limitations, and the data a real project would need. Use only MATLAB, Signal Processing Toolbox and Statistics and Machine Learning Toolbox, and do not modify any supplied file."], newline);
disp(machineLearningPrompt)
%%
%[text] ## 11. Lab E — optional: justify a digital filter
%[text] **Why:** in Part 1 the Smooth Data task reduced the 250 Hz component without anyone asking for it. A good agent asks what must be preserved before it designs a filter.
%[text] **Check before accepting:** the agent asked its questions and waited; at least two designs are compared with magnitude, phase or group delay and transient behavior; the 120 Hz and 250 Hz components survive if you asked for them.
filterDesignPrompt = join([ ...
    "Use the matlab-design-digital-filter skill with the prepared Evaluation channel from WD_Lab_Signal_Data.csv (apply agent_output/prepareWDSignal.m first)." ...
    "Before designing anything, ask me whether the analysis is offline or streaming, which frequency components must be preserved, and whether zero-phase or causal filtering is required. Wait for my answers." ...
    "Then compare at least two viable designs at the measured sample rate, for example an FIR equiripple lowpass and an IIR Butterworth lowpass, and explain magnitude response, phase or group delay, transient behavior and filter order." ...
    "Show the spectrum before and after filtering and confirm that the components I asked to preserve are still present. Do not select a design because the time plot looks smoother." ...
    "Save the reproducible result as agent_output/labE_filter_design.m, run it, and summarize why the selected design meets the stated requirements. Use only MATLAB and Signal Processing Toolbox and do not modify any supplied file."], newline);
disp(filterDesignPrompt)
%%
%[text] ## 12. Review the agent's work
%[text] Generating files is not the end of an engineering task. Ask for a second-pass review, then decide yourself what to accept, revise, or send back with more data.
reviewPrompt = join([ ...
    "Use the matlab-review-code skill to review every file in the agent_output folder, including WDSignalAnalyzerApp.mlapp." ...
    "Check MATLAB syntax, numerical assumptions, sample-rate and unit handling, toolbox dependencies, file-path portability, input validation, plot labeling, test coverage, and whether the written conclusions match the evidence." ...
    "Confirm that no supplied source file was overwritten and that no confidential information was added." ...
    "Do not edit any file. Return findings grouped as Must fix, Should improve and Optional enhancement, with file and line references where possible."], newline);
disp(reviewPrompt)
%%
%[text] ## 13. Participant challenge
%[text] Pick one prompt and change one meaningful constraint, for example: analyze `Reference_um` instead of `Evaluation_um`, request a bandstop investigation around 250 Hz, add a second reference file to the app, or ask Lab D to predict from a different set of features. Before accepting the result, ask:
%[text] - Did the agent use the intended skill and the installed products?
%[text] - Did it inspect the actual data instead of assuming it?
%[text] - Can another participant reproduce the result from the saved files?
%[text] - Are units, assumptions and limitations explicit?
%[text] - Did a person review every important change? \
%%
%[text] ## 14. Troubleshooting
%[text] - If a skill does not trigger, include its exact name in the prompt.
%[text] - If the agent chooses unrelated skills, rerun `setupAgenticToolkit("install")` and keep only the groups required for the work.
%[text] - To update the toolkit, run `setupAgenticToolkit("update")`.
%[text] - If the agent cannot reach MATLAB, check its MCP configuration and run `shareMATLABSession()` again.
%[text] - For proxy, permission or agent-specific configuration problems, use the Configuration and Troubleshooting guide in the toolkit repository.
%[text] - Never place passwords, tokens, customer data or license details in a prompt, script, screenshot or public repository. \
%%
%[text] ## 15. Takeaway
%[text] The MATLAB Agentic Toolkit gives an AI agent access to MATLAB tools and domain skills. Today the same engineering task moved from clicks in Live Tasks, to a prompt, to a tested function, to an app, and to a predictive model, and at every step the engineer set the goal, approved the assumptions and verified the result. Treat AI-generated analysis as a reviewable draft, never as unverified engineering evidence.

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
