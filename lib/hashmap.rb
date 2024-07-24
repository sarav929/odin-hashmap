class HashMap
  MAX_LOAD_FACTOR = 0.75

  def initialize(size)
    @buckets = Array.new(size)
    @size = 0  
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def load_factor
    @size.to_f / @buckets.size
  end

  def rehash
    old_buckets = @buckets
    new_capacity = @buckets.size * 2
    @buckets = Array.new(new_capacity)
    @size = 0
    old_buckets.each do |bucket|
      current = bucket
      while current
        set(current.key, current.value)
        current = current.next
      end
    end
  end

  # add/overwrite entries to hashmap
  def set(key, value)
    rehash if load_factor > MAX_LOAD_FACTOR
    new_node = Node.new(key, value)
    index = hash(key) % @buckets.size
    raise IndexError if index.negative? || index >= @buckets.length
    if @buckets[index].nil? 
      @buckets[index] = new_node
      @size += 1
    else  
      current = @buckets[index]
      while current 
        if current.key == new_node.key 
          current.value = new_node.value 
          return
        end
        if current.next.nil? 
          current.next = new_node 
          @size += 1
          return  
        end
        current = current.next
      end
    end   
  end

  #get(key) takes one argument as a key and returns the value that is assigned to this key. 
  #If key is not found, return nil.
  def get(key)
    index = hash(key) % @buckets.size
    current = @buckets[index]
    while current
      return current.value if current.key == key
      current = current.next
    end
    nil     
  end

  #has?(key) takes a key as an argument 
  #returns true or false based on whether or not the key is in the hash map.
  def has?(key)
    index = hash(key) % @buckets.size
    current = @buckets[index]
    while current 
      if current.key == key 
        return true
      else
        current = current.next
      end
    end
    return false 
  end

  #remove(key) takes a key as an argument
  #If the given key is in the hash map, it should remove the entry with that key 
  #and return the deleted entry’s value. 
  #If the key isn’t in the hash map, it should return nil.
  def remove(key)
    index = hash(key) % @buckets.size
    if !has?(key)
      return nil 
    else       
      current = @buckets[index]
      previous = nil
      while current 
        if current.key == key
          if previous.nil? 
            @buckets[index] = current.next 
          else 
            previous.next = current.next 
          end
          @size -= 1
          return current.value 
        end
        previous = current 
        current = current.next  
      end
    end   
  end

  #length returns the number of stored keys in the hash map
  def length 
    @size
  end  

  #clear removes all entries in the hash map.
  def clear
    @buckets = Array.new(@buckets.size)
    @size = 0
  end

  #keys returns an array containing all the keys inside the hash map.
  def keys 
    keys = []
    @buckets.each do |bucket|
      current = bucket
      while current 
        keys << current.key
        current = current.next
      end
    end   
    return keys 
  end

  #values returns an array containing all the values.
  def values 
    values = []
    @buckets.each do |bucket|
      current = bucket
      while current 
        values << current.value
        current = current.next
      end
    end
    return values 
  end
  
  #entries returns an array that contains each key, value pair. Example: [[first_key, first_value], [second_key, second_value]]
  def entries 
    entries = []
    @buckets.each do |bucket|
      current = bucket 
      while current 
        entries << [current.key, current.value]
        current = current.next
      end
    end
    return entries
  end
end