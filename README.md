## Project Structure
nf-rnaseq-dsl2-human/
├── main.nf                     # Main pipeline entry point (DSL2)
├── nextflow.config             # Global parameters and resource configuration
├── workflows/
│   └── rnaseq.nf               # High-level RNA-seq workflow definition
├── modules/
│   └── fastqc.nf               # FastQC module (quality control)
├── assets/
│   └── samplesheet.csv         # Sample metadata and FASTQ paths
├── data/
│   └── sample2.fastq.gz        # Input single-end FASTQ file
└── results/                    # Output directory (created before execution)
