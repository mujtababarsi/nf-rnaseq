nextflow.enable.dsl=2
include { FASTQC } from '../modules/fastqc'
workflow RNASEQ_WORKFLOW {
    samples_ch = channel.frompath(params.input)
                 .splitCsv(header:true)
                 .map { row ->
                        tuple(row.sample, file(row.fastqc))
                    }
    FASTQC(samples_ch)
}