include { FastQC } from '../modules/fastqc.nf'
include { FASTP  } from '../modules/fastp.nf'
include { STAR_ALIGN }    from '../modules/star.nf'
include { FEATURECOUNTS } from '../modules/featurecounts.nf'
include { MULTIQC } from '../modules/multiqc.nf'

workflow RNASEQ_WORKFLOW {

    take:
    samples_ch

    main:
    /*
     * Run FastQC
     * This returns multiple named outputs
     */
    fastqc_out = FastQC(samples_ch)

    /*
     * Run Fastp trimming
     */
    trimmed = FASTP(samples_ch)
    /*
     * Align reads using STAR
     */
    aligned = STAR_ALIGN(trimmed.trimmed)
    /*
     * Quantify features using FeatureCounts
     */
    counts = FEATURECOUNTS(aligned.bam)
    /*
     * Aggregate reports using MultiQC
     */
    MULTIQC(fastqc_out.html, trimmed.report)

    emit:
    counts
}