class Solution:
    def maxOperations(self, nums: List[int], k: int) -> int:
        
	nums.sort()

        res = 0
        i = 0
	j = len(nums) - 1

        while i < j:
            sum = nums[i] + nums[j]
            if sum == k:
                res += 1
                i += 1
                j -= 1
            elif sum > k:
                j -= 1
            else:
                i += 1

        return res