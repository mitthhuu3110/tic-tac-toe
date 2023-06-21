//
//  BoardView.swift
//  Simple tic-tac-toe
//
//  Created by Mithilesh pmcs
//

import SwiftUI

struct BoardView: View {
    @StateObject private var tess: Tesseract = Tesseract.global
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: Const.Dim.GameWidth, height: Const.Dim.GameWidth)
                .foregroundColor(Const.Colour.Background)
                .cornerRadius(Const.Dim.CornerRadius)
            
            ZStack {
                GeometryReader { geometry in
                    if tess.winInfo.winner != .none {
                        Path { highlight in
                            let rect = geometry.frame(in: CoordinateSpace.named("grid"))
                            // a + bx
                            let a: CGFloat = (Const.Dim.SquareSize / 2)
                            let b: CGFloat = Const.Dim.SquareSize + (Const.Dim.GridSpacing * 3)
                            highlight.move(to: CGPoint(
                                x: rect.minX + a + b * CGFloat(tess.winInfo.startCell.1),
                                y: rect.minY + a + b * CGFloat(tess.winInfo.startCell.0))
                            )

                            highlight.addLine(to: CGPoint(
                                x: rect.minX + a + b * CGFloat(tess.winInfo.endCell.1),
                                y: rect.minY + a + b * CGFloat(tess.winInfo.endCell.0))
                            )
                        }
                        .stroke(style: StrokeStyle(lineWidth: Const.Dim.SquareSize, lineCap: .round))
                        .foregroundColor(Const.Colour.WinHighlight)
                    }
                }
                .coordinateSpace(name: "grid")
                .frame(width: Const.Dim.GridSize - Const.Dim.LSpacing, height: Const.Dim.GridSize - Const.Dim.LSpacing)
                
                VStack {
                    Spacer()
                    Capsule()
                        .frame(width: Const.Dim.GridSize, height: Const.Dim.GridSpacing)
                    Spacer()
                    Capsule()
                        .frame(width: Const.Dim.GridSize, height: Const.Dim.GridSpacing)
                    Spacer()
                }.frame(height: Const.Dim.GridSize, alignment: .center)
                
                HStack {
                    Spacer()
                    Capsule()
                        .frame(width: Const.Dim.GridSpacing, height: Const.Dim.GridSize)
                    Spacer()
                    Capsule()
                        .frame(width: Const.Dim.GridSpacing, height: Const.Dim.GridSize)
                    Spacer()
                }.frame(width: Const.Dim.GridSize, alignment: .center)
                
                VStack(spacing: Const.Dim.GridSpacing * 3) {
                    ForEach(0..<3, id: \.self) {i in
                        HStack(spacing: 15) {
                            ForEach(0..<3, id: \.self) {j in
                                CellView(i, j)
                            }
                        }.frame(width: Const.Dim.GridSize - Const.Dim.LSpacing)
                    }
                }.frame(width: Const.Dim.GridSize - Const.Dim.LSpacing, height: Const.Dim.GridSize - Const.Dim.LSpacing)
            }.frame(width: Const.Dim.GridSize, height: Const.Dim.GridSize)
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
