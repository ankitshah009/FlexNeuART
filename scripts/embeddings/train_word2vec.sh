#!/bin/bash

function check {
  f="$?"
  name=$1
  if [ "$f" != "0" ] ; then
    echo "**************************************"
    echo "* Failed: $name"
    echo "**************************************"
    exit 1
  fi
}

PIPELINE_OUT_PREFIX="$1"

if [ "$PIPELINE_OUT_PREFIX" = "" ] ; then
 echo "Specify the pipeline output top-level directory (1st arg)"
 exit 1
fi

if [ ! -d "$PIPELINE_OUT_PREFIX" ] ; then
  "$PIPELINE_OUT_PREFIX isn't a directory"
  exit 1
fi

SUBSET=$2

if [ "$SUBSET" = "" ] ; then
  echo "Specify a SUBSET: e.g., compr, stackoverflow, ComprMinusManner (2d arg)"
  exit 1
fi

PART=$3

if [ "$PART" = "" ] ; then
  echo "Specify a PART: e.g., train, dev1, dev2, test, tran (3d arg)"
  exit 1
fi

FIELD=$4

if [ "$FIELD" = "" ] ; then
  echo "Specify a FIELD: e.g., text, text_unlemm, bigram, srl, srl_lab, dep, wnss (4th arg)"
  exit 1
fi

DIM=$5

if [ "$DIM" = "" ] ; then
  echo "Specify vectors' dimensionality (5th arg)"
  exit 1
fi

WORD2_VEC_DIR="$6"

if [ "$WORD2_VEC_DIR" = "" ] ; then
 echo "Specify word2vec dir (6th arg)"
 exit 1
fi

if [ ! -d "$WORD2_VEC_DIR" ] ; then
 echo "Not a directory (6th arg): $WORD2_VEC_DIR"
 exit 1
fi

WORD_EMBED_DIR="WordEmbeddings/$SUBSET"
if [ ! -d "WordEmbeddings/" ] ; then
  mkdir -p $WORD_EMBED_DIR
  check "mkdir -p $WORD_EMBED_DIR"
fi

TRAIN_FILE=$WORD_EMBED_DIR/word2vec_train_$FIELD

THREAD_QTY=`scripts/exper/get_cpu_cores.py`
check "THREAD_QTY=`scripts/exper/get_cpu_cores.py`"

fq="$PIPELINE_OUT_PREFIX/$SUBSET/$PART/question_$FIELD"
fa="$PIPELINE_OUT_PREFIX/$SUBSET/$PART/answer_$FIELD"

if [ -f "$fq" -a -f "$fa" ] ; then
  cat $fq $fa > $TRAIN_FILE
  check "cat $fq $fa > $TRAIN_FILE"
  echo "Training file $TRAIN_FILE is generated from questions and answers!"
else
  if [ ! -f "$fa" ] ; then
    echo "Expecting that the answer file exists!"
    exit 1
  fi
  rm -f $TRAIN_FILE
  ln -s $fa $TRAIN_FILE
  check "ln -s $fa $TRAIN_FILE"
  echo "Training file $TRAIN_FILE is now a link to the answers file $fa"
fi


"$WORD2_VEC_DIR/word2vec" -train "$TRAIN_FILE" -threads $THREAD_QTY -output $WORD_EMBED_DIR/word2vec_tran_${FIELD}.$DIM -size $DIM
check "$WORD2_VEC_DIR/word2vec -train $TRAIN_FILE -threads $THREAD_QTY -output $WORD_EMBED_DIR/word2vec_tran_${FIELD}.$DIM -size $DIM"

rm $TRAIN_FILE
check "rm $TRAIN_FILE"