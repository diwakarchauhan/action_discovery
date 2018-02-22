@echo off

echo.
echo Processing the clusters : 
python clusterCommentary.py _ frameCluster_30_20 _
python clusterCommentary.py _ frameCluster_20_10 _
python clusterCommentary.py _ frameCluster_15_10 _

echo.
echo Evaluating relative frequency feature for generated commentaries
python clusterRelativeFrequency.py _ _ cluster_30_20Commentary 0.7
python clusterRelativeFrequency.py _ _ cluster_20_10Commentary 0.001
python clusterRelativeFrequency.py _ _ cluster_15_10Commentary 0.6
python clusterRelativeFrequency.py supervised _ labelCommentary 0.5
python clusterRelativeFrequency.py supervised _ labelCommentaryMerged 0.5

echo.
echo Filtering the cluster results
python filterClusterResult.py _ relativeScorelabel supervised
python filterClusterResult.py _ relativeScorelabelMerged supervised

echo.
echo Evaluating mutual information feature for the commentaries
python clusterMutualInformation.py _ _ _ _ _ 0.5