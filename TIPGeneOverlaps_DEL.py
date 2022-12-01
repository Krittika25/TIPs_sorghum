'''
This script finds the overlap between TIPs in each of the wild sorghum genotype and BTx623
genes
Author: Krittika Krishnan
'''

#Function to read in the genotype files, extract the TE boundaries from the flanking1kb.info file and finding BTx623
#gene overlaps
#flankfile: output from the ITIPs pipeline containing TE+flanking coordinates
#genotypes: list with all the genotype IDs
#gffFile: BTx623 gene annotation file
#oufile: output for this script
def getGeno(flankfile,genotypes,gffFile,outfile):
	TEids={}
	TEcoords={}
	fh=open(outfile,'w')
	with open(flankfile) as flank:
		for l1 in flank:
			t1=l1.rstrip().split("\t")
			Tid=t1[0]
			TEids[Tid]=[]
			TEcoords[t1[0]]=[t1[1],t1[2],t1[3]]
			
	for gindex,gname in enumerate(genotypes):
		#Working with a modified file for the genotypes containing only the TEids and 
		#TE_genotype columns from the pipeline output file (.referenceTEinsertion)
		with open("/Users/krittikakrishnan/Documents/sorghum_genomes/TIPs/"+gname+".txt") as geno:
			geno.readline()
			for l2 in geno:
				t2=l2.rstrip().split("\t")
				ID=t2[0]
				if ID in TEids.keys():
					TEids[ID].append(t2[1])
		
		#Some of the TEids are missing in the genotype files as compared to the BTx623 
		#TE calls. Adding a '-' to indicate missing data in the pipeline output
		for key,value in TEids.items():
			if len(value)==gindex:
				TEids[key].append("-")
	
			
	
	with open(gffFile) as gff:
		gff.readline()
		gff.readline()
		gff.readline()
		for l3 in gff:
			t3=l3.rstrip().split("\t")
			for k,v in TEcoords.items():
				#finding overlaps between TE and gene coordinates in BTx623 with 1000bp flanking
				if (v[0]==t3[0]) and (int(t3[3])-1000 <= int(v[1]) and int(t3[4])+1000 >= int(v[2])) and (t3[2] in "gene"):
					geneID=t3[8].split(";")[1].split("=")[1]
					TEids[k].append(geneID)
	
	for tkey,tvalue in TEids.items():
		fh.write(tkey+"\t"+"\t".join(tvalue)+"\n")
	
	
	
def main():
	genotypes=["Grif16309","pi302118","pi302267","pi329250","pi329251","pi329252",
	"pi369484","pi369487","pi524718","pi532564","pi532565","pi532566","pi532568","pi535995"]
	infile="/Users/krittikakrishnan/Documents/sorghum_genomes/TIPs/BTx623.referenceTEinsertions_and_flanking1kb.info"
	outfile="/Users/krittikakrishnan/Documents/sorghum_genomes/TIPs/TIPOverlaps.out"
	gffFile="/Users/krittikakrishnan/Documents/TEfasta/TEfinderParsing/Sbicolor_454_v3.1.1.gene.gff3"
	getGeno(infile,genotypes,gffFile,outfile)
		
if __name__ == "__main__":
	main()	

			
		
