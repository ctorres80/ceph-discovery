#!/bin/bash
FILE_NAME=$1
echo -e "ceph -s ##############################################################################################################################\n"  > $FILE_NAME
ceph -s >> $FILE_NAME
echo -e "ceph versions ########################################################################################################################\n" >> $FILE_NAME
ceph versions >> $FILE_NAME
echo -e "ceph osd pool ls detail ##############################################################################################################\n" >> $FILE_NAME
ceph osd pool ls detail >> $FILE_NAME
echo -e "ceph osd tree ########################################################################################################################\n"  >> $FILE_NAME
ceph osd tree >> $FILE_NAME
echo -e "\nceph osd df tree ###################################################################################################################\n" >> $FILE_NAME
ceph osd df tree >> $FILE_NAME
echo -e "\nceph osd crush rule ls #############################################################################################################\n" >> $FILE_NAME
ceph osd crush rule ls >> $FILE_NAME
ceph osd crush rule ls | while read rule
	do ceph osd crush rule dump $rule >> $FILE_NAME
done
echo -e "\nceph mon metadata ################################################################################################################\n" >> $FILE_NAME
ceph mon metadata | jq -r 'map({name,addrs,ceph_version_short,cpu,device_ids,kernel_version,mem_swap_kb,mem_total_kb}) | (first | keys_unsorted) as $keys | map([to_entries[] | .value]) as $rows | $keys,$rows[] | @csv' >> $FILE_NAME
echo -e "\nceph osd metadata ################################################################################################################\n" >> $FILE_NAME
ceph osd metadata | jq -r 'map({hostname,id,ceph_version_short,devices,default_device_class,device_ids,distro_description,kernel_version,osd_data,osd_objectstore}) | (first | keys_unsorted) as $keys | map([to_entries[] | .value]) as $rows | $keys,$rows[] | @csv' >> $FILE_NAME
echo -e "\nceph fs dump ######################################################################################################################\n" >> $FILE_NAME
ceph fs dump >> $FILE_NAME
ceph fs status cephfs >> $FILE_NAME
echo -e "\nceph auth ls ######################################################################################################################\n" >> $FILE_NAME
ceph auth ls >> $FILE_NAME
