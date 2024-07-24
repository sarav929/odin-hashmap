class HashMap 
  #create the buckets array
  
  def initialize
    @buckets = Array.new
  end

  # hash function
  def hash(key) 
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value)
    new_node = Node.new(key, value)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    
    if @buckets[index].nil? #handle empty bucket, just add the node
      @buckets[index] = new_node
      return 
    else # if not empty 
      current = @buckets[index]
      while current # iterate content in bucket 
        if current.key == new_node.key # if same keys
          current.value = new_node.value #overwrite value
          return
        end
        if current.next.nil? #reached the end of the linked list
          current.next = new_node # append node at the end of the list
          return  
        end
      end
    end   
  end

  #get(key) takes one argument as a key and returns the value that is assigned to this key. 
  #If key is not found, return nil.
    
  def get(key)
    index = hash(key)
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
    index = hash(key)
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
    index = hash(key)
       
    if !has?(key) # if the key doesn't exists
      return nil 
    else       
      current = @buckets[index]
      previous = nil

      while current 
        if current.key == key
          if previous.nil? #it's the first element of the list
            @buckets[index] = current.next #replace with next element
          else #it's not the first element
            previous.next = current.next #update previous pointer to the next element 
          end
          return current.value 
        end
        previous = current # update prev
        current = current.next # update current 
      end
    end   
  end

  #length returns the number of stored keys in the hash map
  def length 
    count = 0
    current = @buckets[0]

    while current
      count += 1
      current = current.next
    end
    count 
  end  

  #clear removes all entries in the hash map.
  def clear
    @buckets = Array.new
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