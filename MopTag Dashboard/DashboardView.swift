//
//  DashboardView.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import Charts
import SwiftUI

struct DashboardView: View {
    @State private var viewModel: DashboardViewModel = .init()

    struct ToyShape: Identifiable {
        var type: String
        var count: Double
        var id = UUID()
    }

    @State var data: [ToyShape] = [
        .init(type: "Mon", count: 50),
        .init(type: "Tue", count: 60),
        .init(type: "Wed", count: 40),
        .init(type: "Thu", count: 50),
        .init(type: "Fri", count: 40),
        .init(type: "Sat", count: 40),
        .init(type: "Sun", count: 30)
    ]

    @State var data2: [ToyShape] = [
        .init(type: "Mon", count: 60),
        .init(type: "Tue", count: 70),
        .init(type: "Wed", count: 80),
        .init(type: "Thu", count: 90),
        .init(type: "Fri", count: 10),
        .init(type: "Sat", count: 50),
        .init(type: "Sun", count: 30)
    ]

    @State var data3: [ToyShape] = [
        .init(type: "Mon", count: 15),
        .init(type: "Tue", count: 20),
        .init(type: "Wed", count: 10),
        .init(type: "Thu", count: 30),
        .init(type: "Fri", count: 10),
        .init(type: "Sat", count: 20),
        .init(type: "Sun", count: 18)
    ]

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 32) {
                    statistics
                    charts
                    missingMopsTable
                }
                .padding(.horizontal, 32)
                .padding(.bottom)
                .padding(.top, 120)
            }
            header
        }
        .sheet(isPresented: $viewModel.presentingResetSheet) {
            viewModel.dismissResetSheet()
        } content: {
            NavigationStack(path: $viewModel.resetTagPath) {
                ResetTagView(status: .waitingForTag)
                    .environment(viewModel)
                    .task {
                        await viewModel.waitForTag()
                    }
                    .navigationDestination(for: ResetTagStatus.self) { page in
                        Group {
                            switch page {
                            case .waitingForTag:
                                ResetTagView(status: .waitingForTag)
                                    .task {
                                        await viewModel.waitForTag()
                                    }
                            case .tagFound:
                                ResetTagView(status: .tagFound)
                            case .resettingTag:
                                ResetTagView(status: .resettingTag)
                            case .resetSuccess:
                                ResetTagView(status: .resetSuccess)
                            }
                        }
                        .toolbar(.hidden)
                        .environment(viewModel)
                    }
            }
            .interactiveDismissDisabled()
        }
        .alert(
            "Are you sure to end the shift?",
            isPresented: $viewModel.presentingEndShiftAlert) {
                Button("End", role: .destructive) {

                }
            }
    }

    private var header: some View {
        HStack {
            title
            Spacer()
            resetTagButton
            endShiftButton
        }
        .padding(.horizontal, 32)
        .padding(.vertical)
        .background(.thinMaterial)
    }

    private var title: some View {
        VStack(alignment: .leading) {
            Text("MopTag Dashboard")
                .font(.largeTitle)
            Text("Bozen Hospital")
                .font(.headline)
        }
    }

    private var resetTagButton: some View {
        Button {
            viewModel.presentingResetSheet = true
        } label: {
            Label(
                "Reset tag".uppercased(),
                systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90"
            )
            .foregroundStyle(.white)
            .bold()
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .background(.blue.gradient, in: .capsule)
        }
    }

    private var endShiftButton: some View {
        Button {
            viewModel.presentingEndShiftAlert = true
        } label: {
            Label(
                "End shift".uppercased(),
                systemImage: "xmark"
            )
            .foregroundStyle(.white)
            .bold()
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .background(.red.gradient, in: .capsule)
        }
    }

    private var statistics: some View {
        HStack(spacing: 32) {
            StatisticsCard(
                name: "Mops currently in use",
                value: "30",
                icon: "toilet",
                color: .blue
            )
            StatisticsCard(
                name: "Mops currently in storage",
                value: "27",
                icon: "archivebox",
                color: .gray
            )
            StatisticsCard(
                name: "Missing mops",
                value: "19",
                icon: "exclamationmark.triangle",
                color: .red
            )
        }
    }

    private var charts: some View {
        HStack(spacing: 32) {
            currentlyUsedChart
            currentlyInStorageChart
            missingMopsChart

        }
    }

    private var currentlyUsedChart: some View {
        Chart {
            BarMark(
                x: .value("Shape Type", data[0].type),
                y: .value("Total Count", data[0].count)
            )
            BarMark(
                x: .value("Shape Type", data[1].type),
                y: .value("Total Count", data[1].count)
            )
            BarMark(
                x: .value("Shape Type", data[2].type),
                y: .value("Total Count", data[2].count)
            )
            BarMark(
                x: .value("Shape Type", data[3].type),
                y: .value("Total Count", data[3].count)
            )
            BarMark(
                x: .value("Shape Type", data[4].type),
                y: .value("Total Count", data[4].count)
            )
            BarMark(
                x: .value("Shape Type", data[5].type),
                y: .value("Total Count", data[5].count)
            )
            BarMark(
                x: .value("Shape Type", data[6].type),
                y: .value("Total Count", data[6].count)
            )
        }
        .modifier(CustomChartModifier(color: .blue))
    }

    private var currentlyInStorageChart: some View {
        Chart {
            BarMark(
                x: .value("Shape Type", data2[0].type),
                y: .value("Total Count", data2[0].count)
            )
            BarMark(
                x: .value("Shape Type", data2[1].type),
                y: .value("Total Count", data2[1].count)
            )
            BarMark(
                x: .value("Shape Type", data2[2].type),
                y: .value("Total Count", data2[2].count)
            )
            BarMark(
                x: .value("Shape Type", data2[3].type),
                y: .value("Total Count", data2[3].count)
            )
            BarMark(
                x: .value("Shape Type", data2[4].type),
                y: .value("Total Count", data2[4].count)
            )
            BarMark(
                x: .value("Shape Type", data2[5].type),
                y: .value("Total Count", data2[5].count)
            )
            BarMark(
                x: .value("Shape Type", data2[6].type),
                y: .value("Total Count", data2[6].count)
            )
        }
        .modifier(CustomChartModifier(color: .gray))
    }

    private var missingMopsChart: some View {
        Chart {
            LineMark(
                x: .value("Shape Type", data3[0].type),
                y: .value("Total Count", data3[0].count)
            )
            LineMark(
                x: .value("Shape Type", data3[1].type),
                y: .value("Total Count", data3[1].count)
            )
            LineMark(
                x: .value("Shape Type", data3[2].type),
                y: .value("Total Count", data3[2].count)
            )
            LineMark(
                x: .value("Shape Type", data3[3].type),
                y: .value("Total Count", data3[3].count)
            )
            LineMark(
                x: .value("Shape Type", data3[4].type),
                y: .value("Total Count", data3[4].count)
            )
            LineMark(
                x: .value("Shape Type", data3[5].type),
                y: .value("Total Count", data3[5].count)
            )
            LineMark(
                x: .value("Shape Type", data3[6].type),
                y: .value("Total Count", data3[6].count)
            )
        }
        .modifier(CustomChartModifier(color: .red))
    }

    private var missingMopsTable: some View {
        VStack(spacing: 15) {
            Text("Missing mops")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack{
                HStack {
                    Group {
                        Text("ID")
                        Text("Location")
                        Text("Date")
                        Text("Time")
                        Text("Washings")
                    }
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 8)
                HStack {
                    Group {
                        Text("254")
                        Text("Ala est")
                        Text("2024-11-12")
                        Text("13:00")
                        Text("30")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
                HStack {
                    Group {
                        Text("354")
                        Text("Ala ovest")
                        Text("2024-11-10")
                        Text("12:00")
                        Text("2")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
                HStack {
                    Group {
                        Text("274")
                        Text("Corridoio C")
                        Text("2024-11-08")
                        Text("12:21")
                        Text("7")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
                HStack {
                    Group {
                        Text("25")
                        Text("Bagni")
                        Text("2024-11-04")
                        Text("11:31")
                        Text("70")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
                HStack {
                    Group {
                        Text("467")
                        Text("Ala nord")
                        Text("2024-11-01")
                        Text("10:14")
                        Text("90")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
            }
        }
        .padding(.horizontal)
    }
}

private struct ResetTagView: View {
    @Environment(DashboardViewModel.self) private var viewModel
    let status: ResetTagStatus

    var body: some View {
        VStack {
            if status != .resettingTag {
                closeSheetButton
            }
            VStack(spacing: 40) {
                Text(status.title(tag: viewModel.tagToReset))
                    .fontDesign(.rounded)
                    .font(.title)
                VStack {
                    loadingAnimation
                    if status == .waitingForTag {
                        Text("Place it nearby the reader")
                            .fontDesign(.rounded)
                            .font(.title3)
                    }
                }
                if status == ResetTagStatus.tagFound {
                    Button {
                        Task {
                            await viewModel.resetTag()
                        }
                    } label: {
                        Text("Reset it".uppercased())
                            .foregroundStyle(.white)
                            .bold()
                            .padding(.horizontal, 18)
                            .padding(.vertical, 12)
                            .background(.red.gradient, in: .capsule)
                    }
                }
                if status == ResetTagStatus.resetSuccess {
                    Button {
                        Task {
                            viewModel.resetTagPath = [.waitingForTag]
                        }
                    } label: {
                        Label(
                            "Reset another one".uppercased(),
                            systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90"
                        )
                        .foregroundStyle(.white)
                        .bold()
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .background(.blue.gradient, in: .capsule)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 32)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    private var closeSheetButton: some View {
        Button {
            viewModel.presentingResetSheet = false
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.gray)
                .font(.title)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    private var loadingAnimation: some View {
        Image(systemName: status.icon)
            .resizable()
            .foregroundStyle((status == .resetSuccess ? Color.green : .blue).gradient)
            .symbolEffect(
                .bounce,
                options: .speed(0.5),
                isActive: status == ResetTagStatus.waitingForTag
            )
            .symbolEffect(
                .rotate,
                options: .speed(0.5),
                isActive: status == ResetTagStatus.resettingTag
            )
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
}

private struct StatisticsCard: View {
    let name: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
                .padding()
                .background(color.gradient, in: .rect(cornerRadius: 10))
            VStack(alignment: .trailing) {
                Text(name)
                    .font(.title2)
                Text(value)
                    .font(.title3)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            Color.white
                .cornerRadius(15)
                .shadow(color: color, radius: 3)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(color.gradient, lineWidth: 2)
        }
    }
}

struct CustomChartModifier: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .padding()
            .frame(height: 300)
            .background(color.gradient, in: .rect(cornerRadius: 15))
    }
}

#Preview {
    DashboardView()
}
