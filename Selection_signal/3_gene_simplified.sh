
### input file = ***.gene resulted from 2_get_gene_belong_to_block.pl;

cat $1 | perl -npe 's/ID=//g' | perl -npe 's/;Name=/\t/g' | cut -f1,2,3,4 > ${1}list;
rm $1;