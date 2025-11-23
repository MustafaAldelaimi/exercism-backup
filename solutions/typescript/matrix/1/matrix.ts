export class Matrix {
  constructor(
    public matrixString: string
  )  {
  }

  get rows(): number[][] {
    return this.matrixString
            .split('\n')
            .map(strNums => {
              return strNums.split(' ')
                        .map(strNum => Number(strNum))
        })
  }

  get columns(): number[][] {
    const columns: number[][] = []

    this.rows.forEach(_row => columns.push([]))
    
    this.rows.forEach((row) => {
      row
      .forEach((elm, index) => {
        columns[index].push(elm)
      })
    })

    return columns
  }
}
