# this script is repsonsible for configuring the special plugins like seo, mobile-studio

function configure_seo(){
    if [ $install_profile_number -ne $PROFILE_ANALYSIS_SERVER -a \
    $install_profile_number -ne $PROFILE_SEARCH_SERVER ]; then
    print_and_log "Configuring seo plugin ..."
    xmlstarlet ed -P -L \
       -s /Context -t elem -n TMP -v '' \
       -i //TMP -t attr -n name -v escenic/solr-base-uri \
       -i //TMP -t attr -n value -v http://${search_host}:${search_port}/solr/collection1 \
       -i //TMP -t attr -n type -v java.lang.String \
       -i //TMP -t attr -n override -v false \
       -r //TMP -v Environment \
       $tomcat_base/conf/context.xml
   fi
}


function configure_special_plugins(){
  print_and_log "Checking for special plugins ..."
  if [[ $type == "engine" && -e $escenic_conf_dir/ece-$instance_name.conf ]]; then
     source $escenic_conf_dir/ece-$instance_name.conf
     print_and_log "Found tomcat base : $tomcat_base"
  
     if [[ "$ear_download_list" =~ "seo-" ]]; then
        configure_seo
     fi
  fi
}