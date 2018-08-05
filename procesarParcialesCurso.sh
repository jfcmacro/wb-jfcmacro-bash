for i in parcial*
do
    if [ -d $i ]; then
        cd $i
        for j in $1-$2-$3-*.tex
        do
            if [ -f $j ]; then 
                pdflatex $j
                pdflatex $j
            fi
        done
        cd ..
    fi
done
