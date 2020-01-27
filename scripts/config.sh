# This should be consistent with common_proc.sh and config.py

# Point COLLECT_ROOT to the location you want to use as
# the root directory for all collections/indices.

COLLECT_ROOT="collections"

# The structure of sub-directories is outlined below

#
# Each collection is supposed to be stored in respective sub-directories.
# See a description/location of sub-directories below, which are assumed
# to exist (by many scripts).
#
# $COLLECT_ROOT
#     <Collection sub-directory>
#         $INPUT_RAW_SUBDIR (optional)
#         $INPUT_DATA_SUBDIR
#             $DEFAULT_TRAIN_SUBDIR (can be overriden)
#             $DEV_SUBDIR (optional)
#             $DEV1_SUBDIR (optional)
#             $DEV2_SUBDIR (optional)
#             $BITEXT_TRAIN_SUBDIR (optional, can also be created using
#                                   scripts/data_convert/split_train4bitext.sh
#                                   from the train subdir data)
#
#         $DERIVED_DATA_SUBDIR
#             $BITEXT_SUBDIR (optional)
#             $EMBED_SUBDIR (optional)
#             $LM_FINETUNE_SUBDIR (optional)
#
#         $EXPER_SUBDIR
#
#         $FWD_INDEX_SUBDIR
#         $LUCENE_INDEX_SUBDIR
#         $LUCENE_CACHE_SUBDIR
#

# Original input data directory
INPUT_RAW_SUBDIR="input_raw"

# Processed multi-field input data (possibly compressed question and/or answer JSONs)
INPUT_DATA_SUBDIR="input_data"
# Derived data subdirectory
DERIVED_DATA_SUBDIR="derived_data"

# This keeps data generated by experiments (results, models, etc)
EXPER_SUBDIR="results"

# Index directories.
FWD_INDEX_SUBDIR="forward_index"
LUCENE_INDEX_SUBDIR="lucene_index"
# By default training scripts cache candidate
# documents obtained from Lucene or any other
# candidate generator to speed up training
LUCENE_CACHE_SUBDIR="lucene_cache"

# Embeddings are stored within the derived-data sub-directory
EMBED_SUBDIR="embeddings"

# This is a bunch of sub-directories for input data
DEFAULT_TRAIN_SUBDIR="train" # This only a default that can be overriden
# The dev* directories can be optional, there can be, e.g., dev1, dev2 or just a single dev
DEV_SUBDIR="dev"
DEV1_SUBDIR="dev1"
DEV2_SUBDIR="dev2"
BITEXT_TRAIN_SUBDIR="train_bitext"

# A directory with data for BERT LM fine-tuning
LM_FINETUNE_SUBDIR="lm_finetune_data"
LM_FINETUNE_SET_PREF="set"

# Parallel corpora sub-directory
BITEXT_SUBDIR="bitext"
# Parameters to train Model 1
GIZA_SUBDIR="giza"
GIZA_ITER_QTY=5

# Coordinate ascent (LETOR algorithm) training parameters
DEFAULT_METRIC_TYPE="NDCG@20"
DEFAULT_NUM_RAND_RESTART=10
DEFAULT_NUM_TREES=100

# QREL file name
QREL_FILE="qrels.txt"
# The default run id for TREC-like run files
FAKE_RUN_ID="fake_run"

# This value should match Lucene's query field
QUERY_FIELD_NAME=text

DEFAULT_INTERM_CAND_QTY=1000
DEFAULT_TRAIN_CAND_QTY=20
DEFAULT_TEST_CAND_QTY_LIST=10,50,100,250

# Report/trec_run sub-dirs and files
LETOR_SUBDIR="letor"
TRECRUNS_SUBDIR="trec_runs"
REP_SUBDIR="rep"

STAT_FILE="stat_file"

SEP_DEBUG_LINE="================================================================================"

TEST_PART_PARAM="testPart"
EXPER_SUBDIR_PARAM="experSubdir"
TEST_ONLY_PARAM="testOnly"



function getExperDirBase {
  collectSubdir="$1"
  testSet="$2"
  experSubdir="$3"

  checkVarNonEmpty "collectSubdir"
  checkVarNonEmpty "testSet"
  checkVarNonEmpty "experSubdir"
  checkVarNonEmpty "EXPER_SUBDIR"

  echo "$collectSubdir/$EXPER_SUBDIR/$testSet/$experSubdir"

}
