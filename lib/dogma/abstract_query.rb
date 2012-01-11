# Base contract for ORM queries. Base class for Query and NativeQuery.
#
#use Doctrine\DBAL\Types\Type,
#Doctrine\ORM\Query\QueryException,
#Doctrine\DBAL\Cache\QueryCacheProfile;
#
class Dogma::AbstractQuery
  # Hydration mode constants

  # Hydrates an object graph. This is the default behavior.
  HYDRATE_OBJECT = 1

  # Hydrates an array graph.
  HYDRATE_ARRAY = 2

  # Hydrates a flat, rectangular result set with scalar values.
  HYDRATE_SCALAR = 3

  # Hydrates a single scalar value.
  HYDRATE_SINGLE_SCALAR = 4

  # Very simple object hydrator (optimized for performance).
  HYDRATE_SIMPLEOBJECT = 5

  attr_accessor :rsm    # ResultSetMapping
  attr_accessor :params # The parameter map of this query
  attr_accessor :paramTypes   # The parameter type map of this query
  attr_accessor :rsm    # ResultSetMapping The user-specified ResultSetMapping to use
  attr_accessor :em     # The entity manager used by this query object
  attr_accessor :hints  # The map of query hints
  attr_accessor :hydrationMode
  attr_accessor :queryCacheProfile
  attr_accessor :expireResultCache

  def initialize entityManager
    self.em = entityManager
    self.hydrationMode = HYDRATE_OBJECT
    self.hints = {}
    self.paramTypes = {}
  end

    #/**
     #* Frees the resources used by the query object.
     #*
     #* Resets Parameters, Parameter Types and Query Hints.
     #*
     #* @return void
     #*/
    #public function free()
    #{
        #$this->_params = array();
        #$this->_paramTypes = array();
        #$this->_hints = array();
    #}

    #/**
     #* Sets a query parameter.
     #*
     #* @param string|integer $key The parameter position or name.
     #* @param mixed $value The parameter value.
     #* @param string $type The parameter type. If specified, the given value will be run through
     #*                     the type conversion of this type. This is usually not needed for
     #*                     strings and numeric types.
     #* @return Doctrine\ORM\AbstractQuery This query instance.
     #*/
    #public function setParameter($key, $value, $type = null)
    #{
        #$key = trim($key, ':');
        
        #if ($type === null) {
            #$type = Query\ParameterTypeInferer::inferType($value);
        #}
        
        #$this->_paramTypes[$key] = $type;
        #$this->_params[$key] = $value;
        
        #return $this;
    #}

    #/**
     #* Sets a collection of query parameters.
     #*
     #* @param array $params
     #* @param array $types
     #* @return Doctrine\ORM\AbstractQuery This query instance.
     #*/
    #public function setParameters(array $params, array $types = array())
    #{
        #foreach ($params as $key => $value) {
            #if (isset($types[$key])) {
                #$this->setParameter($key, $value, $types[$key]);
            #} else {
                #$this->setParameter($key, $value);
            #}
        #}
        #return $this;
    #}

    #/**
     #* Defines a cache driver to be used for caching result sets and implictly enables caching.
     #*
     #* @param Doctrine\Common\Cache\Cache $driver Cache driver
     #* @return Doctrine\ORM\AbstractQuery
     #*/
    #public function setResultCacheDriver($resultCacheDriver = null)
    #{
        #if ($resultCacheDriver !== null && ! ($resultCacheDriver instanceof \Doctrine\Common\Cache\Cache)) {
            #throw ORMException::invalidResultCacheDriver();
        #}
        #if ($this->_queryCacheProfile) {
            #$this->_queryCacheProfile = $this->_queryCacheProfile->setResultCacheDriver($resultCacheDriver);
        #} else {
            #$this->_queryCacheProfile = new QueryCacheProfile(0, null, $resultCacheDriver);
        #}
        #return $this;
    #}

    #/**
     #* Returns the cache driver used for caching result sets.
     #*
     #* @deprecated
     #* @return Doctrine\Common\Cache\Cache Cache driver
     #*/
    #public function getResultCacheDriver()
    #{
        #if ($this->_queryCacheProfile && $this->_queryCacheProfile->getResultCacheDriver()) {
            #return $this->_queryCacheProfile->getResultCacheDriver();
        #} else {
            #return $this->_em->getConfiguration()->getResultCacheImpl();
        #}
    #}

    #/**
     #* Set whether or not to cache the results of this query and if so, for
     #* how long and which ID to use for the cache entry.
     #*
     #* @param boolean $bool
     #* @param integer $lifetime
     #* @param string $resultCacheId
     #* @return Doctrine\ORM\AbstractQuery This query instance.
     #*/
    #public function useResultCache($bool, $lifetime = null, $resultCacheId = null)
    #{
        #if ($bool) {
            #$this->setResultCacheLifetime($lifetime);
            #$this->setResultCacheId($resultCacheId);
        #} else {
            #$this->_queryCacheProfile = null;
        #}
        #return $this;
    #}

    #/**
     #* Defines how long the result cache will be active before expire.
     #*
     #* @param integer $lifetime How long the cache entry is valid.
     #* @return Doctrine\ORM\AbstractQuery This query instance.
     #*/
    #public function setResultCacheLifetime($lifetime)
    #{
        #if ($lifetime === null) {
            #$lifetime = 0;
        #} else {
            #$lifetime = (int)$lifetime;
        #}
        #if ($this->_queryCacheProfile) {
            #$this->_queryCacheProfile = $this->_queryCacheProfile->setLifetime($lifetime);
        #} else {
            #$this->_queryCacheProfile = new QueryCacheProfile($lifetime);
        #}
        #return $this;
    #}

    #/**
     #* Retrieves the lifetime of resultset cache.
     #*
     #* @deprecated
     #* @return integer
     #*/
    #public function getResultCacheLifetime()
    #{
        #return $this->_queryCacheProfile ? $this->_queryCacheProfile->getLifetime() : 0;
    #}

    #/**
     #* Defines if the result cache is active or not.
     #*
     #* @param boolean $expire Whether or not to force resultset cache expiration.
     #* @return Doctrine\ORM\AbstractQuery This query instance.
     #*/
    #public function expireResultCache($expire = true)
    #{
        #$this->_expireResultCache = $expire;
        #return $this;
    #}

    #/**
     #* Retrieves if the resultset cache is active or not.
     #*
     #* @return boolean
     #*/

    #/**
     #* Change the default fetch mode of an association for this query.
     #*
     #* $fetchMode can be one of ClassMetadata::FETCH_EAGER or ClassMetadata::FETCH_LAZY
     #*
     #* @param  string $class
     #* @param  string $assocName
     #* @param  int $fetchMode
     #* @return AbstractQuery
     #*/
    #public function setFetchMode($class, $assocName, $fetchMode)
    #{
        #if ($fetchMode !== Mapping\ClassMetadata::FETCH_EAGER) {
            #$fetchMode = Mapping\ClassMetadata::FETCH_LAZY;
        #}

        #$this->_hints['fetchMode'][$class][$assocName] = $fetchMode;
        #return $this;
    #}

  # Gets the list of results for the query.
  #
  # Alias for execute(array(), $hydrationMode = HYDRATE_OBJECT).
  #
  # @return array
  def getResult hm = HYDRATE_OBJECT
    execute [], hm
  end

  # Gets the array of results for the query.
  #
  # Alias for execute(array(), HYDRATE_ARRAY).
  #
  # @return array
  def getArrayResult
    execute [], HYDRATE_ARRAY
  end

  # Gets the scalar results for the query.
  #
  # Alias for execute(array(), HYDRATE_SCALAR).
  #
  # @return array
  def getScalarResult
    execute [], HYDRATE_SCALAR
  end

    #/**
     #* Get exactly one result or null.
     #*
     #* @throws NonUniqueResultException
     #* @param int $hydrationMode
     #* @return mixed
     #*/
    #public function getOneOrNullResult($hydrationMode = null)
    #{
        #$result = $this->execute(array(), $hydrationMode);

        #if ($this->_hydrationMode !== self::HYDRATE_SINGLE_SCALAR && ! $result) {
            #return null;
        #}

        #if (is_array($result)) {
            #if (count($result) > 1) {
                #throw new NonUniqueResultException;
            #}
            #return array_shift($result);
        #}

        #return $result;
    #}

    #/**
     #* Gets the single result of the query.
     #*
     #* Enforces the presence as well as the uniqueness of the result.
     #*
     #* If the result is not unique, a NonUniqueResultException is thrown.
     #* If there is no result, a NoResultException is thrown.
     #*
     #* @param integer $hydrationMode
     #* @return mixed
     #* @throws NonUniqueResultException If the query result is not unique.
     #* @throws NoResultException If the query returned no result.
     #*/
    #public function getSingleResult($hydrationMode = null)
    #{
        #$result = $this->execute(array(), $hydrationMode);

        #if ($this->_hydrationMode !== self::HYDRATE_SINGLE_SCALAR && ! $result) {
            #throw new NoResultException;
        #}

        #if (is_array($result)) {
            #if (count($result) > 1) {
                #throw new NonUniqueResultException;
            #}
            #return array_shift($result);
        #}

        #return $result;
    #}

    #/**
     #* Gets the single scalar result of the query.
     #*
     #* Alias for getSingleResult(HYDRATE_SINGLE_SCALAR).
     #*
     #* @return mixed
     #* @throws QueryException If the query result is not unique.
     #*/
    #public function getSingleScalarResult()
    #{
        #return $this->getSingleResult(self::HYDRATE_SINGLE_SCALAR);
    #}


  # Executes the query and returns an IterableResult that can be used to incrementally
  # iterate over the result.
  #
  # Parameters
  # * l_params - Any additional query parameters.
  # * l_hydrationMode - Processing mode to be used during the hydration process.
  #
  #* @return Internal::Hydration::IterableResult
  def iterate l_params = nil, l_hydrationMode = nil
    self.hydrationMode = l_hydrationMode unless l_hydrationMode
    self.params = l_params unless l_params

    stmt = do_Execute

    em.newHydrator(hydrationMode).iterate(stmt, resultSetMapping, hints)
  end

  # Executes the query.
  #
  # Parameters
  # * l_params - Any additional query parameters.
  # * l_hydrationMode - Processing mode to be used during the hydration process.
  #
  # @return mixed
  def execute l_params = nil, l_hydrationMode = nil
    self.hydrationMode = l_hydrationMode unless l_hydrationMode
    self.params = l_params unless l_params
    stmt = doExecute

    # OPTIMIZE А не должны ли мы тут Exception ждать?
    if stmt.is_a? Fixnum
      return stmt
    else
      return em.getHydrator(hydrationMode).hydrateAll(stmt, resultSetMapping, hints)
    end
  end

    #/**
     #* Set the result cache id to use to store the result set cache entry.
     #* If this is not explicitely set by the developer then a hash is automatically
     #* generated for you.
     #*
     #* @param string $id
     #* @return Doctrine\ORM\AbstractQuery This query instance.
     #*/
    #public function setResultCacheId($id)
    #{
        #if ($this->_queryCacheProfile) {
            #$this->_queryCacheProfile = $this->_queryCacheProfile->setCacheKey($id);
        #} else {
            #$this->_queryCacheProfile = new QueryCacheProfile(0, $id);
        #}
        #return $this;
    #}

    #/**
     #* Get the result cache id to use to store the result set cache entry if set.
     #*
     #* @deprecated
     #* @return string
     #*/
    #public function getResultCacheId()
    #{
        #return $this->_queryCacheProfile ? $this->_queryCacheProfile->getCacheKey() : null;
    #}

    #public function __clone()
        #$this->_params = array();
        #$this->_paramTypes = array();
        #$this->_hints = array();
end
