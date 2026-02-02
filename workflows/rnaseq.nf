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
    fastp_out = FASTP(samples_ch)
    /*
     * Align reads using STAR
     */
    star_out = STAR_ALIGN(fastp_out.trimmed)
    /*
     * Quantify features using FeatureCounts
     */
    counts_out = FEATURECOUNTS(star_out.bam)
    /*
     * Aggregate reports using MultiQC
     */
    qc_files = Channel.empty()
        .mix(fastqc_out)
        .mix(fastp_out)
        .mix(star_out)
        .mix(counts_out.counts)
        .collect()
        
    
    MULTIQC(qc_files)
     
    emit:
    
   bam = star_out.bam
   counts = counts_out.counts
}
