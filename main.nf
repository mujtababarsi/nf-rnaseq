#!/usr/bin/env nextflow

/*
 * Main entry point for the RNA-seq DSL2 pipeline
 */

nextflow.enable.dsl=2

/*
 * Import the main RNA-seq workflow
 */
include { RNASEQ_WORKFLOW } from './workflows/rnaseq'

/*
 * Execute the workflow
 */
workflow {
    RNASEQ_WORKFLOW()
}
