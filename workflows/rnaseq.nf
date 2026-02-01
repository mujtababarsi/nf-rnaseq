nextflow.enable.dsl=2

include { FASTQC } from './modules/fastqc' // import FastQC module

workflow RNASEQ_WORKFLOW {
    samples_ch = channel.fromPath (params.input)
// workflow to perform RNA-seq quality control
 workflow RNASEQ_WORKFLOW { 

    //channels
    samples_ch = Channel.fromPath(params.input)
                 .splitCsv(header:true)
                 .map { row ->
                        tuple(row.sample, file(row.fastqc))
                    }
    FASTQC(samples_ch)
}

