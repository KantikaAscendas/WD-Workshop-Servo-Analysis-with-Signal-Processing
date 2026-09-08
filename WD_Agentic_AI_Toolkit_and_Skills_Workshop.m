%[text] # WD Agentic AI Workshop: MATLAB Agentic Toolkit and Skills
%[text] This participant lab shows how to connect an AI coding agent to a local MATLAB session and how to write effective prompts for signal processing, App Designer, machine learning, and control engineering. The exercises use only sample data. Do not upload confidential WD data, credentials, license numbers, proprietary source code, or unreleased product information to an AI service.
%[text:tableOfContents] {"heading":"Workshop flow"}
%[text] - Check the local MATLAB environment
%[text] - Install MATLAB Agentic Toolkit and selected skill groups
%[text] - Connect and verify the AI agent
%[text] - Use structured prompts for Signal Processing and App Designer
%[text] - Try an optional Machine Learning exercise when licensed
%[text] - Use a Control System Toolbox prompt without Simulink
%[text] - Review generated work before accepting it \
%%
%[text] ## 1. What you need before the workshop
%[text] - A local MATLAB installation. The current MATLAB Agentic Toolkit repository states MATLAB R2021a or later.
%[text] - Git, plus a supported AI coding agent and its required account or subscription.
%[text] - Internet access for downloading the installer and any AI-agent communication. Corporate proxy settings may require support from your IT team.
%[text] - This workshop repository downloaded or cloned to a local folder.
%[text] - MATLAB and Signal Processing Toolbox for the core exercises.
%[text] - Control System Toolbox for the control exercise.
%[text] - Statistics and Machine Learning Toolbox only for the optional machine-learning exercise. \
%[text] Official resources: [MATLAB Agentic Toolkit](https://www.mathworks.com/products/matlab-agentic-toolkit.html) and the [MATLAB Agentic Toolkit GitHub repository](https://github.com/matlab/matlab-agentic-toolkit).
%%
%[text] ## 2. Check this workshop folder and installed products
%[text] Run this section first. It checks the supplied sample file and reports only the products that matter to this lab.
workshopFile = which('WD_Agentic_AI_Toolkit_and_Skills_Workshop');
if strlength(workshopFile) == 0
    workshopFolder = string(pwd);
else
    workshopFolder = string(fileparts(workshopFile));
end
sampleDataFile = fullfile(workshopFolder, 'sample_servo_data.csv');
installedProductInfo = ver;
installedProducts = string({installedProductInfo.Name})';
productsToCheck = ["MATLAB"; "Signal Processing Toolbox"; "Control System Toolbox"; "Statistics and Machine Learning Toolbox"];
isInstalled = arrayfun(@(productName) any(strcmpi(installedProducts, productName)), productsToCheck);
environmentCheck = table(productsToCheck, isInstalled, VariableNames={'Product','Installed'})
sampleDataAvailable = isfile(sampleDataFile)
%%
%[text] ## 3. Install MATLAB Agentic Toolkit
%[text] Use the current official installation workflow:
%[text] 1. Download `agenticToolkitInstaller.mltbx` from the official GitHub repository.
%[text] 2. Open the `.mltbx` file in MATLAB and approve the add-on installation.
%[text] 3. Run `setupAgenticToolkit("install")` in the MATLAB Command Window.
%[text] 4. Select the AI agent you will use and only the skill groups needed for this workshop.
%[text] 5. Complete any agent-specific configuration shown by the installer. \
%[text] Recommended skill groups for this workshop are `matlab-core`, `matlab-data-import-and-analysis`, `signal-processing`, `matlab-app-building`, and `control-systems`. Select `ai-and-statistics` only when you will run the optional machine-learning lab. Installing fewer relevant groups helps the agent select the intended skill reliably.
%[text] The switch below is intentionally `false`, so **Run All** cannot start installation. After installing the `.mltbx` file, change it to `true` and run only this code section if the presenter asks you to.
runToolkitInstaller = false;
if runToolkitInstaller
    setupAgenticToolkit("install")
else
    disp("Installation skipped. Change runToolkitInstaller to true only when ready.")
end
%%
%[text] ## 4. Connect the AI agent to this MATLAB session
%[text] `shareMATLABSession()` allows a configured AI agent to use the MATLAB session that already contains your files, paths, and workspace. Review every proposed tool action before approval, especially file writes, installs, and commands.
%[text] This switch is also intentionally `false`. Change it to `true` and run only this section when instructed.
shareCurrentMATLABSession = false;
if shareCurrentMATLABSession
    shareMATLABSession()
else
    disp("MATLAB session sharing skipped. Enable it only when you are ready to connect.")
end
%%
%[text] ## 5. Verify the connection before changing files
%[text] Copy the prompt below into your AI coding agent. The agent should query MATLAB and report the environment without modifying any file.
connectionCheckPrompt = join([...
    "Use the connected MATLAB session to report the MATLAB release and list the installed products."...
    "Confirm whether Signal Processing Toolbox, Control System Toolbox, and Statistics and Machine Learning Toolbox are available."...
    "List the installed MATLAB skills relevant to signal processing, app building, machine learning, and control systems."...
    "Do not install anything and do not create or modify files yet."], newline);
disp(connectionCheckPrompt)
%%
%[text] ## 6. A reliable prompt structure
%[text] A useful engineering prompt normally contains five parts:
%[text] 1. **Context** — the data, engineering situation, and current folder.
%[text] 2. **Goal** — the result you want, not only a command.
%[text] 3. **Skills and products** — name the skill when you want it to trigger, and limit the solution to installed products.
%[text] 4. **Constraints** — protect source files, avoid unavailable toolboxes, and state that sample models are illustrative.
%[text] 5. **Deliverable and verification** — specify the output file and ask the agent to run or test it. \
%[text] If a skill does not activate automatically, explicitly write: **Use the `<skill-name>` skill to ...**
%%
%[text] ## 7. Prompt Lab A — inspect servo signals
%[text] This exercise asks the agent to prepare and analyze the supplied sample CSV using Signal Processing Toolbox. The source CSV must remain unchanged.
signalAnalysisPrompt = join([...
    "Use the matlab-prepare-signal-data and matlab-analyze-time-frequency-content skills."...
    "Work with sample_servo_data.csv in the current workshop folder."...
    "First inspect the column names, infer the sample rate from Time_s, and check for missing values, duplicate timestamps, nonuniform sampling, and outliers."...
    "Then analyze Acceleration_g in the time and frequency domains, identify the strongest frequency components, and calculate clearly labeled engineering metrics."...
    "Recommend a short Signal Analyzer app workflow that a participant can repeat interactively."...
    "Use only MATLAB and Signal Processing Toolbox. Do not use Simulink, System Identification Toolbox, or proprietary data."...
    "Create a new Live Script named participant_output_signal_analysis.m in the workshop folder. Do not modify the CSV or any supplied workshop file."...
    "Run the generated Live Script, fix errors, and finish with a concise findings-and-limitations summary."], newline);
disp(signalAnalysisPrompt)
%%
%[text] ## 8. Prompt Lab B — investigate a digital filter
%[text] Good agentic work includes clarification and engineering checks. This prompt requires the agent to ask about phase and deployment needs before selecting a filter.
filterDesignPrompt = join([...
    "Use the matlab-design-digital-filter skill with sample_servo_data.csv."...
    "Before designing the filter, ask me whether the analysis is offline or streaming, which signal component must be preserved, and whether zero phase or causal operation is required."...
    "After I answer, compare at least two viable filter approaches using the measured sample rate."...
    "Explain magnitude response, phase or delay, transient behavior, and numerical considerations. Do not choose a filter from appearance alone."...
    "Use only MATLAB and Signal Processing Toolbox, preserve the original data, and validate the final design on a copy of Acceleration_g."...
    "Save the reproducible result as participant_output_filter_design.m and summarize why the selected design fits the stated requirements."], newline);
disp(filterDesignPrompt)
%%
%[text] ## 9. Prompt Lab C — build an App Designer application
%[text] App Designer is part of MATLAB. This prompt demonstrates how the agent can turn a script workflow into an editable `.mlapp` without overwriting the supplied WD example app.
appDesignerPrompt = join([...
    "Use the matlab-build-app and matlab-build-chart skills."...
    "Build an editable App Designer app named ParticipantSignalExplorer.mlapp in the workshop folder."...
    "The app must load sample_servo_data.csv, let the user select a numeric signal, show a time plot and spectrum, apply simple preprocessing, calculate RMS and peak-to-peak values, and export processed data."...
    "Use uigridlayout for resize behavior. Keep callbacks thin and place data loading, validation, preprocessing, plotting, and metric calculations in private methods."...
    "Use only MATLAB and Signal Processing Toolbox. Do not overwrite WDSignalExplorer.mlapp or any source data."...
    "First summarize the proposed component layout and callback flow in five bullets, then implement the app."...
    "Open or run the app to validate startup, load the sample CSV, test the main controls, fix errors, and report the files created."], newline);
disp(appDesignerPrompt)
%%
%[text] ## 10. Optional Prompt Lab D — machine learning
%[text] Run this only if the environment check reports **Statistics and Machine Learning Toolbox = true**. The prompt deliberately checks the license first. The labels are synthetic and are suitable for teaching only; they are not validated fault labels or an engineering decision rule.
machineLearningPrompt = join([...
    "Use the matlab-classify-tabular-data skill. First verify that Statistics and Machine Learning Toolbox is installed and licensed."...
    "If it is unavailable, stop and explain which product is required. Do not install a product and do not substitute an unavailable function."...
    "If it is available, use sample_servo_data.csv to create an educational classification workflow."...
    "Segment Acceleration_g into windows and derive interpretable features such as RMS, peak-to-peak value, crest factor, and dominant frequency."...
    "Create clearly documented synthetic Normal and Review labels only for this exercise. State prominently that these labels are not WD ground truth."...
    "Prevent train-test leakage, use a reproducible split, compare simple candidate models, and report a confusion matrix plus suitable performance metrics."...
    "Also explain how Classification Learner could be used interactively with the feature table."...
    "Save and run participant_output_machine_learning.m, then summarize assumptions, limitations, and the data needed for a real project."], newline);
disp(machineLearningPrompt)
%%
%[text] ## 11. Prompt Lab E — control analysis without Simulink
%[text] This exercise uses a simple illustrative transfer function to show a Control System Toolbox workflow. It is not a model of a WD actuator or drive.
controlPrompt = join([...
    "Use the most relevant installed skill from the control-systems skill group."...
    "Use only MATLAB and Control System Toolbox. Do not use Simulink, Simscape, or System Identification Toolbox."...
    "Create the clearly labeled illustrative plant G = tf(1,[0.018 0.22 1]). Explain what its poles and step response tell us."...
    "Compare a baseline closed loop with a PID controller tuned using pidtune. Report stability, rise time, settling time, overshoot, and a simple output-disturbance response."...
    "Recommend where Linear System Analyzer, PID Tuner, and Control System Designer add value for interactive investigation."...
    "Do not claim that the model or controller represents a WD product. Explain what measured data and requirements would be needed before a real design."...
    "Save the analysis as participant_output_control_analysis.m, run it, fix errors, and summarize the tradeoffs rather than declaring one controller universally best."], newline);
disp(controlPrompt)
%%
%[text] ## 12. Review the agent's work
%[text] Generating a file is not the end of an engineering task. Ask a second-pass reviewer to check correctness, licensing assumptions, reproducibility, and whether source files were preserved.
reviewPrompt = join([...
    "Use the matlab-review-code skill to review the participant_output files created in this workshop."...
    "Check MATLAB syntax, numerical assumptions, toolbox dependencies, file-path portability, input validation, plots and units, and whether the conclusions match the evidence."...
    "Confirm that no supplied source file was overwritten and that no confidential information was added."...
    "Do not edit files yet. Return findings grouped as Must fix, Should improve, and Optional enhancement, with file and line references where possible."], newline);
disp(reviewPrompt)
%%
%[text] ## 13. Participant challenge
%[text] Choose one prompt and change one meaningful constraint. Examples include analyzing `PositionError_um` instead of acceleration, requesting a bandstop investigation around an observed narrowband component, changing the app layout, or defining a different control-design priority. Before accepting the result, ask:
%[text] - Did the agent use the intended skill?
%[text] - Did it inspect the actual data and installed products?
%[text] - Can another participant reproduce the result?
%[text] - Are units, assumptions, and limitations explicit?
%[text] - Did a human review every important change? \
%%
%[text] ## 14. Troubleshooting and update commands
%[text] - If a skill does not trigger, include its exact name in the prompt.
%[text] - If the agent chooses unrelated skills, rerun `setupAgenticToolkit("install")` and keep only the groups required for the work.
%[text] - To obtain toolkit updates, run `setupAgenticToolkit("update")`.
%[text] - If the AI agent cannot reach MATLAB, verify its MCP configuration and run `shareMATLABSession()` again when using a shared existing session.
%[text] - For corporate proxy, permission, or agent-specific configuration problems, use the official Configuration and Troubleshooting guide in the toolkit repository.
%[text] - Never place passwords, tokens, customer data, or license details in a prompt, script, screenshot, or public GitHub repository. \
%%
%[text] ## 15. Workshop takeaway
%[text] MATLAB Agentic Toolkit gives an AI agent access to MATLAB tools and domain skills. The engineer remains responsible for requirements, data governance, approvals, verification, and the final technical decision. Use AI-generated analysis as a reviewable draft, not as unverified engineering evidence.

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
