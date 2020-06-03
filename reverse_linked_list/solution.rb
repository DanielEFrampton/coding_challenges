# Assumed definition (provided by Leetcode) for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end

# Example: 1->2->3->4->5->NULL to 5->4->3->2->1->NULL
# How to do? 
    # in one pass:
        # iterate through list, for each node:
            # temporarily store reference to next node
            # de-couple node
            # set node-under-construction as next node to current node (it is now head)

def reverse_list(head)
    current_node = head
    reversed_list_head = nil
    until current_node.next == nil
        next_node = current_node.next
        current_node.next = reversed_list_head
        reversed_list_head = current_node
        current_node = next_node
    end
    reversed_list_head
end