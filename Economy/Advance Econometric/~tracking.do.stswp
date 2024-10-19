//标准化
   summarize totalscore
   local mean = r(mean)
   local sd = r(sd)
   generate standardized_totalscore = (totalscore - `mean') / `sd'
   //稳健回归
   regress standardized_totalscore tracking ,robust
   //聚类稳健的标准误
   regress standardized_totalscore tracking , vce(cluster schoolid)
   
   //删除缺失值
   drop if missing(standardized_totalscore, tracking ,agetest ,girl, etpteacher, percentile)
   //回归
   regress standardized_totalscore tracking agetest girl etpteacher percentile ,robust
   regress standardized_totalscore tracking agetest girl etpteacher percentile ,vce(cluster schoolid)