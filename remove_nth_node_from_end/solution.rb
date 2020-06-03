# Definition (provided by Leetcode) for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end

# [1,2,3,4,5] = 
# target scenario with n = 2
# when current_node hits 5, counter should be pointing at 4

# Edge cases:
    # (if n is always valid, presumably the linked list will always be at least 1 node long.)
    # Account for 1-node-long list.
    # Account for n being 1, in which case the node before it needs to drop it.

def remove_nth_from_end(head, n)
    # Account for single-length list
    return head.val = nil if head.next == nil
    
    # Setting variables for main loop
    current_node = head
    target_node = head
    node_before_target = head
    counter = 1
    
    # Main loop to locate nth node
    until current_node.next == nil # Break case: pointer found tail
        current_node = current_node.next # Move pointer forward
        counter += 1 # Increment counter
        if counter > n # When counter passes n,
            target_node = target_node.next # Move target pointer forward
        end
        if counter > n + 1
            node_before_target = node_before_target.next
        end
    end
    
    # Removing nth node by replacing with subsquent node or setting to nil if last
    if target_node.next # if nth node is not the tail
        target_node.val = target_node.next.val
        target_node.next = target_node.next.next
    else # if nth node is the tail
        node_before_target.next = nil
    end
    
    # Returning head
    head
end