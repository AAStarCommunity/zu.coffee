bool isNotNull(dynamic target){
  if(target == null) return false;
  if('$target'.replaceAll('Null', '').replaceAll('null', '').trim().isEmpty) return false;
  return true;
}