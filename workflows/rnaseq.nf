nextflow.enable.dsl=2

include { FASTQC } from './modules/fastqc' // import FastQC module

workflow RNASEQ_WORKFLOW {
    samples_ch = channel.fromPath (params.input)
                 .splitCsv(header:true)
                 .map { row ->
                        tuple(row.sample, file(row.fastq))
                    }
    FASTQC(samples_ch)
}

