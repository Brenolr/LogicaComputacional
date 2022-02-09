
def compose(a,b):
    # c=[]
    # for ai in a:
    #     for bi in b:
    #         if(ai[1]==bi[0]):
    #             c.append([ai[0],bi[1]])
    # return c
    return compose_1(a,b,0,0,[])

def compose_1(a,b,ai,bi,acc):
    if(ai > len(a)-1):
        return(acc)

    if a[ai][1]==b[bi][0]:
        acc.append([a[ai][0],b[bi][1]])
    
    if(bi == len(b)-1):
        return(compose_1(a,b,ai+1,0,acc))
    else:
        return(compose_1(a,b,ai,bi+1,acc))
    
def main():
    a = [[1,2], [3, 2],[3, 4]]
    b = [[2,1], [4, 3], [5, 7]] 
    print(compose(a,b))
main()