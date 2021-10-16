# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Boolean}

# pseudo-code
    # recursive method:
        # return true if root node passed is nil (or check before call)

def is_valid_bst(root)
    # check if past end of branch
    return true if root == nil

    # check for valid values
    return false unless valid_left_val(root) && valid_right_val(root)

    # check for valid values in subtrees
    is_valid_bst(root.left, root.val) && is_valid_bst(root.right, root.val)
end

def valid_left_val(root)
    if root.left
        return false unless root.left.val < root.val
        if root.left.left
            return false unless root.left.left.val < root.val
        end
        if root.left.right
            return false unless root.left.right.val < root.val
        end
    end
end

def valid_right_val(root)
    return true if root.right == nil
    root.right.val > root.val
end