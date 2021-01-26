# babette

<details>

* Version: 2.2
* GitHub: NA
* Source code: https://github.com/cran/babette
* Date/Publication: 2020-11-06 09:20:02 UTC
* Number of recursive dependencies: 117

Run `cloud_details(, "babette")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘babette-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: babette
    > ### Title: babette: A package for Bayesian phylogenetics.
    > ### Aliases: babette
    > 
    > ### ** Examples
    > 
    > if (is_beast2_installed()) {
    ...
    +   # Clean up temporary files created by babette
    +   bbt_delete_temp_files(
    +     inference_model = inference_model,
    +     beast2_options = beast2_options
    +   )
    + }
    Error in if (!os %in% c("mac", "unix", "win")) { : 
      argument is of length zero
    Calls: is_beast2_installed -> <Anonymous>
    Execution halted
    ```

# beastier

<details>

* Version: 2.2.1
* GitHub: https://github.com/ropensci/beastier
* Source code: https://github.com/cran/beastier
* Date/Publication: 2020-10-30 14:50:03 UTC
* Number of recursive dependencies: 91

Run `cloud_details(, "beastier")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘beastier-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: are_beast2_input_lines
    > ### Title: Would these lines of text, when written to a file, result in a
    > ###   valid BEAST2 input file?
    > ### Aliases: are_beast2_input_lines
    > 
    > ### ** Examples
    > 
    > if (is_beast2_installed() && is_on_ci()) {
    +   get_beastier_path("anthus_2_4.xml")
    + }
    Error in if (!os %in% c("mac", "unix", "win")) { : 
      argument is of length zero
    Calls: is_beast2_installed -> <Anonymous>
    Execution halted
    ```

# mcbette

<details>

* Version: 1.13
* GitHub: https://github.com/ropensci/mcbette
* Source code: https://github.com/cran/mcbette
* Date/Publication: 2020-12-05 13:20:02 UTC
* Number of recursive dependencies: 149

Run `cloud_details(, "mcbette")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘mcbette-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: est_marg_lik
    > ### Title: Estimate the marginal likelihood for an inference model.
    > ### Aliases: est_marg_lik
    > 
    > ### ** Examples
    > 
    > if (can_run_mcbette()) {
    ...
    +   est_marg_lik(
    +     fasta_filename = fasta_filename,
    +     inference_model = inference_model,
    +     beast2_options = beast2_options
    +   )
    + }
    Error in if (!os %in% c("mac", "unix", "win")) { : 
      argument is of length zero
    Calls: can_run_mcbette -> <Anonymous> -> <Anonymous>
    Execution halted
    ```

