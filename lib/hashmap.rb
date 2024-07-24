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

end