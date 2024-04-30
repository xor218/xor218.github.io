

# unset maketitle

maketitle(){
    # //获取参数个数
    if [ $#  -eq 0 ]; then
        echo "Usage: maketitle title ]"
        return 1
    fi
    # 获取所有参数
    local title=$1
    # 获取当前时间
    local date=$(date "+%Y-%m-%d")
    # //格式化时间-参数-参数.markdown
    local filename=$(date "+%Y-%m-%d")
    for i in $@
    do
        filename=$filename-$i
    done
    filename=$filename.md

    # //创建文件
    touch $filename
    # //写入文件
    echo "---" >> $filename
    echo "layout: default" >> $filename
    echo "title: \"$@\"" >> $filename
    # date:   2024-04-26 15:59:09 +0800 格式
    echo "date:   $date $(date "+%H:%M:%S %z")" >> $filename
    echo "categories: [update,$(basename $(pwd))] " >> $filename
    echo "---" >> $filename

    echo "Create $filename success!"
    
}