function [ new_ref ] = change_ref_length( ref,new_len )
    height = size(ref,1);
    old_len = size(ref,2);

    new_ref = zeros(height,new_len);
    for indx = 1:new_len
        from_indx = floor(((old_len-1)/(new_len-1)).*(indx-1) + 1.5);
        new_ref(:,indx) = ref(:,from_indx);
    end

end

