function [C,rank2] = r_r_e_f(A)

rank2 = 0;     %it is the dimension of the matrix. It is the same for the row-space and column space of a matrix

[row,column] = size(A);

for r = 1:row     %iterates through the rows
    if abs(A(r,r)) < 0.00000000001      %checks if first element is 0 otherwise the  operations will show NAN
        for c = (r+1):row          %have to iterate from the row below the chosen row to not mess up the previous rows correct allignment
            if abs(A(c,r)) > 0.00000000001    %checks if the row to swap has 0 as the element
                swap = c;
            end
        end
        if exist("swap",'var')   %checks if the swap function was possible if needed. If not then the matrix is singular
            temp = A(swap,:);      %swapping mechanism begins
            A(swap,:) = A(r,:);
            A(r,:) = temp;          %swapping done 
        end
    end

    if A(r,r) ~= 0   %A check for the last element of the last column since it can be swapped with any other row and thus might mess up the whole rref form
       A(r,:) = A(r,:)/A(r,r);     %after the row is alligned so as to it can divided. We divide the row to get 1 at the needed place
       for c = 1:row   %if you take the range from c = r:row, then you will get the REF form
           if r ~= c
           A(c,:) = A(c,:) - A(r,:)*A(c,r);           %need to get the values below to 0
           end
       end
       rank2 = rank2 + 1;
    end
end

C = A;



%Basis of My Loop is taken from a random matrix of 3 x 3 dimensions
%1st column
%augA(1,:) = augA(1,:)/augA(1,1);
%augA(2,:) = augA(2,:) - augA(1,:)*augA(2,1);
%augA(3,:) = augA(3,:) - augA(1,:)*augA(3,1);
%2nd Column
%augA(2,:) = augA(2,:)/augA(2,2);
%augA(1,:) = augA(1,:) - augA(2,:)*augA(1,2);
%augA(3,:) = augA(3,:) - augA(2,:)*augA(3,2);
%3rd Column
%augA(3,:) = augA(3,:)/augA(3,3);
%augA(1,:) = augA(1,:) - augA(3,:)*augA(1,3);
%augA(2,:) = augA(2,:) - augA(3,:)*augA(2,3);


