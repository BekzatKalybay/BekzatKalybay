//
//  StockChartView.swift
//  EG Stocks
//
//  Created by Bekzat Kalybayev on 05.03.2022.
//

import UIKit
import Charts

/// View to show a chart
final class StockChartView: UIView {
    
    /// Chart View ViewModel
    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxis: Bool
        let fillColor: UIColor
    }
    
    /// Chart View
    private let chartView: LineChartView = {
        let chart = LineChartView()
        chart.pinchZoomEnabled = false
        chart.setScaleEnabled(true)
        chart.xAxis.enabled = false
        chart.drawGridBackgroundEnabled = false
        chart.legend.enabled = false
        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false
        
        return chart
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = bounds
    }
    
    /// Reset the chart View
    func reset() {
        chartView.data = nil
    }
    
    /// Configure view
    /// - Parameter viewModel: View ViewModel
    func configure(with viewModel: ViewModel) {
        var entries = [ChartDataEntry]()
        
        for (index, value) in viewModel.data.enumerated() {
            entries.append(
                .init(
                    x: Double(index),
                    y: value
                )
            )
        }
        
        chartView.rightAxis.enabled = viewModel.showAxis
        chartView.legend.enabled = viewModel.showLegend
        
        let dataSet = LineChartDataSet(entries: entries, label: "7 Days")
        dataSet.fillColor = viewModel.fillColor
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
    
}
