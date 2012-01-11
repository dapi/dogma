# Represents a native SQL query.
#
class Dogma::NativeQuery < Dogma::AbastractQuery

  attr_accessor :sql, :rsm

  def doExecute
    #$params = $this->_params;
    #$types = $this->_paramTypes;
    #if ($params) {
    #if (is_int(key($params))) {
    #ksort($params);
    #ksort($types);
    #$params = array_values($params);
    #$types = array_values($types);
    #}
    #}
    em.getConnection.executeQuery sql, params, paramTypes, queryCacheProfile
  end
end
