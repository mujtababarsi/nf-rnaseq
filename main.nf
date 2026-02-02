#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
 * Load the RNA-seq workflow
 */
include { RNASEQ_WORKFLOW } from './workflows/rnaseq.nf'

/*
 * Read samplesheet and create a channel:
 * (sample_id, fastq_file)
 */
Channel
    .fromPath(params.samplesheet)
    .splitCsv(header: true)
    .map { row ->
    row.fastq_2 ?
        tuple(row.sample_id, file(row.fastq_1), file(row.fastq_2)) :
        tuple(row.sample_id, file(row.fastq_1))
    }
    .set { samples_ch }

/*
 * Run workflow
 */
workflow {
    RNASEQ_WORKFLOW(samples_ch)
}
