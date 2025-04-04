if ~defined __FAT_INC__
__FAT_INC__ equ 1


struc FAT12 sectors_per_cluster, root_entries, volume_label {
	.bpb.bytes_per_sector:		dw $200
	.bpb.sector_per_cluster:	db sectors_per_cluster	;; $001
	.bpb.reserved_sectors:		dw $001
	.bpb.number_of_fats:		db $002
	.bpb.root_entries:			dw root_entries			;; $0E0
	.bpb.total_sectors:			dw $B40
	.bpb.media:					db $0F0
	.bpb.sectors_per_fat:		dw $009
	.bpb.sectors_per_track:		dw $012
	.bpb.heads_per_cylinder:	dw $002
	.bpb.hidden_sectors:		dd $000
	.bpb.total_sectors_big:		dd $000
	.bs.drive_number:			db $000
	.bs.unused:					db $000
	.bs.ext_boot_signature:		db $029
	.bs.serial_number:			dd $A0A1A2A3
	.bs.volume_label:			db volume_label	;; 11 bytes
	.bs.file_system:			db "FAT12   "	;; 08 bytes
}

end if