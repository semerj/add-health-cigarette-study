OR = function(model, model_type, se='naive', id) {
  # Calculte OR and compute Standard Errors using the Delta Method
  require(BSagri)        # needed for GEE
  require(multiwayvcov)  # needed for GLM
  coef = coefficients(summary(model))
  or = exp(coef[,1])
  df = data.frame(or)
  row.names(df) = row.names(coef)
  colnames(df) = 'OR'
  n = length(or)
  if (model_type == 'gee') {
    if (se == 'naive') {
      vcov_model = model$naive.variance
    } else if (se == 'robust') {
      vcov_model = model$robust.variance
    }
  } else if (model_type == 'glm' & se == 'robust') {
    vcov_model = cluster.vcov(model, id)
  } else {
    vcov_model = vcov(model)
  }
  for (i in 1:n) {
    grad = or[i]
    vb = vcov_model[i,i]
    df[i,'Std. Error'] = sqrt(grad %*% vb %*% grad)
  }
  return(df)
}