/*
 * RNA-seq main workflow (DSL2)
 * Current steps:
 *   1) FastQC  – raw read quality control
 *   2) Fastp   – adapter & quality trimming (single-end)
 */

include { FastQC } from '../modules/fastqc.nf'
include { FASTP  } from '../modules/fastp.nf'

workflow RNASEQ_WORKFLOW {

    /*
     * Input channel:
     * tuple(sample_id, fastq)
     */
    take:
    samples_ch

    main:
    /*
     * Step 1: Quality control on raw reads
     */
    qc_results = FastQC(samples_ch)

    /*
     * Step 2: Trim reads
     */
    trimmed_reads = FASTP(samples_ch)

    /*
     * Outputs are emitted for downstream steps
     */
    emit:
    qc_results
    trimmed_reads
}
