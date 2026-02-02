#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
 * Load the RNA-seq workflow
 */
include { RNASEQ_WORKFLOW } from './workflows/rnaseq.nf'

/*
 * Read samplesheet and create a channel
 */
Channel
    .fromPath(params.samplesheet)
    .splitCsv(header: true)
    .map { row ->
        // Fix 1: Add checkIfExists to ensure file is actually found
        def r1 = file(row.fastq_1, checkIfExists: true)
        
        // Fix 2: Group paired reads into a list [r1, r2] to match module input
        if (row.fastq_2) {
            def r2 = file(row.fastq_2, checkIfExists: true)
            return tuple(row.sample_id, [r1, r2]) 
        } else {
            return tuple(row.sample_id, r1)
        }
    }
    .set { samples_ch }

/*
 * Run workflow
 */
workflow {
    RNASEQ_WORKFLOW(samples_ch)
}   