#!/bin/sh
# Operation System Course's Educoder exercises shell script.
# 课后作业4.1（第2关）：LDTR 与 LDT 描述符

DownloadSite=${1:-Gitee}
readonly DownloadSite

TaskName="4.1.kehou-2"
TmpDir="/tmp/${TaskName}"

mkdir -p "${TmpDir}"

download_file() {
  Url="$1"
  Out="$2"

  echo "Downloading: ${Url}"
  wget --timeout=20 --tries=3 -O "${Out}" "${Url}"

  if [ $? -ne 0 ]; then
    echo "Download failed: ${Url}"
    exit 1
  fi

  if [ ! -s "${Out}" ]; then
    echo "Downloaded file is empty: ${Out}"
    exit 1
  fi
}

case ${DownloadSite} in
  Gitee)
    BaseUrl="https://gitee.com/TheEastIsleStoker/EduCoder_OperationSys/raw/main/Source/${TaskName}"

    download_file "${BaseUrl}/第四关.txt" "${TmpDir}/第四关.txt"
    download_file "${BaseUrl}/gdb.log" "${TmpDir}/gdb.log"
    download_file "${BaseUrl}/dbg.log" "${TmpDir}/dbg.log"
    ;;

  Github)
    BaseUrl="https://raw.githubusercontent.com/TheEastIsleStoker/EduCoder_OperationSys/main/Source/${TaskName}"

    download_file "${BaseUrl}/第四关.txt" "${TmpDir}/第四关.txt"
    download_file "${BaseUrl}/gdb.log" "${TmpDir}/gdb.log"
    download_file "${BaseUrl}/dbg.log" "${TmpDir}/dbg.log"
    ;;

  *)
    echo "Unknown download site: ${DownloadSite}"
    echo "Usage: sh $0 [Gitee|Github]"
    exit 1
    ;;
esac

mv -f "${TmpDir}/第四关.txt" "/data/workspace/myshixun/第四关.txt"
mv -f "${TmpDir}/gdb.log" "/root/gdb.log"
mv -f "${TmpDir}/dbg.log" "/root/dbg.log"

echo "Checking generated files..."
ls -l "/data/workspace/myshixun/第四关.txt" "/root/gdb.log" "/root/dbg.log"

echo "${TaskName} finished."
exit 0