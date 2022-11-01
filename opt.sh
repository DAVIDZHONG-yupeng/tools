INPUT=($*)
#OPTS=('--tag' '--version' '--prefix')

for opt in ${OPTS[*]}
do
    num=0
    attribute=`echo ${opt} | tr -d '-' | tr '[:lower:]' '[:upper:]'`
    for input in ${INPUT[*]}
    do
        input_key=`echo ${input} | awk -F '=' '{print $1}'`
        if [[ ${input_key} == "${opt}" ]]
        then
            eval ${attribute}=`echo ${input} | awk -F '=' '{print $2}'`
            input_value=`eval echo '$'"${attribute}"`
            [ -z ${input_value} ]&&echo "${input_key} cannot empty"&&exit
            unset INPUT[${num}]
            eval ${attribute}_CHECK=1
        fi
        num=$[num+1]
    done
done

function CHECK_OPTS(){
    local INPUT=($*)
    for check_item in ${INPUT[*]}
    do
        local opt=`echo ${check_item} | tr -d '-' | tr '[:lower:]' '[:upper:]'`
        local check=`eval echo '$'"${opt}_CHECK"`
        if [ -z ${check} ]
        then
            echo "pleace enther ${check_item}"
            exit
        fi
    done
}

#CHECK_OPTS --tag --version
#echo ${PREFIX}
